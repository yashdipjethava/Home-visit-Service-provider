import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voloc/views/screens/about_us.dart';
import 'package:voloc/views/screens/user_image.dart';
import '../../logic/bloc/user/user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadUserEvent()),
      child: const _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  _signOut(context) {
    showDialog(
      context: context,
      builder: (context) {
      return CupertinoAlertDialog(content: const Text("Are you sure to LogOut?"),
    actions: [
      TextButton(onPressed: () async {
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login');
      }, child: const Text("LogOut")),
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: const Text("Stay"))
    ],);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final userEmail = state.userModel?.email;
          final userName = state.userModel?.username;
          final number = state.userModel?.number;
          final userImage = state.userModel?.image;
          if (state.error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error!)));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> UserImage(image: userImage!,)));
                        },
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: state.isLoading
                              ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/img/person.png'),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      const AssetImage('assets/img/person.png'),
                                  foregroundImage: NetworkImage('$userImage'),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: Text(
                        "Hey, User you are special for us.Hope our service makes you happier",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                            "UserName:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                      Text(
                        state.isLoading ? 'UserName' : '$userName',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                            "Email:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                      Text(
                        state.isLoading ? 'Email' : '$userEmail',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                            "Mobile:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                      Text(
                        state.isLoading ? 'Mobile' : '$number',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 0.1),
                const SizedBox(height: 10),
                profileMenuWidget(
                    title: "About us",
                    icon: Icons.info_outline,
                    onpress: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AboutUs()));
                    }),
                profileMenuWidget(
                    title: "Log out",
                    icon: Icons.logout,
                    textcolor: Colors.red,
                    endIcon: false,
                    onpress: () {
                      _signOut(context);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class profileMenuWidget extends StatelessWidget {
  const profileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.orangeAccent,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textcolor)),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 15.0, color: Colors.black))
          : null,
    );
  }
}

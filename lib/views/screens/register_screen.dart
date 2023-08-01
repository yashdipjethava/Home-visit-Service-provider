import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voloc/views/screens/login_screen.dart';
import 'package:voloc/views/screens/tab_screen.dart';

import '../../logic/bloc/login/login_bloc.dart';

class Register_screen extends StatelessWidget {
  const Register_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: const _UserRegistration(),
      ),
    );
  }
}
class _UserRegistration extends StatefulWidget {
  const _UserRegistration({Key? key}) : super(key: key);

  @override
  State<_UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<_UserRegistration> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _mobileno = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _mobileno.dispose();
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screensize.width*0.31,top: screensize.height*0.1),
              child: Image.asset('assets/img/signup.png',height: 170,width: 170,fit: BoxFit.cover,),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screensize.width * 0.25, top: screensize.height * 0.3),
              child: Text('Create Account',
                  style: GoogleFonts.roboto(
                      color: Colors.grey.shade900,
                      fontSize: 35,
                      fontWeight: FontWeight.w500
                  )),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 300, right: 35, left: 35),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade400,
                        child: const Icon(Icons.add_a_photo_outlined,size: 25,color: Colors.black,),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 4),
                          ),
                          label: const Text('Username'),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          hintText: "Enter the Username",
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black26,
                          )),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _mobileno,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 4),
                          ),
                          label: const Text('Mobile no'),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          hintText: "Enter the Mobile no",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black26,
                          )),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 4),
                          ),
                          label: const Text('Email'),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          hintText: "Enter the Email",
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.black26,
                          )),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15,),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        String? error;
                        bool visibility = true;
                        if (state is LoginPasswordInvalidState) {
                          error = state.error;
                        }
                        if (state is PassVisibilityState) {
                          visibility = state.isOn;
                        }
                        return TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(width: 4),
                            ),
                            errorText: error,
                            label: const Text('Password'),
                            labelStyle:  TextStyle(color: Colors.grey.shade700),
                            hintText: "Enter the Password",
                            prefixIcon: const Icon(Icons.lock_outline,color: Colors.black26,),
                            suffixIcon: IconButton(
                              icon: Icon(visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                visibility
                                    ? BlocProvider.of<LoginBloc>(context)
                                    .add(PassVisibilityFalseEvent())
                                    : BlocProvider.of<LoginBloc>(context)
                                    .add(PassVisibilityTrueEvent());
                              },
                            ),
                          ),
                          obscureText: visibility,
                          onChanged: (value) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginPasswordChangedEvent(
                                    password: _password.text));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.all(screensize.width * 0.01),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                            onPressed: () async{
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                        const LogInScreen()));
                              }, child: Text('Sign up',style: GoogleFonts.roboto(fontSize: 20,color: const Color(0xE2EAF5FF),fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogInScreen(),
                                  ));
                            },
                            child: Text(
                              'Have an Account ? ',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  color: Colors.black,
                              ),
                            )
                        ),
                        Container(
                          height: 35,
                          width: 70,
                          decoration:BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async{
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                      const LogInScreen()));
                            }, child: Text('Login',style: GoogleFonts.roboto(fontSize: 17,color: const Color(0xE2EAF5FF),fontWeight: FontWeight.w500),),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/cubit/internet/cubit/internet_cubit.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => InternetCubit(),
          ),
        ],
        child: const _UserLogIn(),
      ),
    );
  }
}

class _UserLogIn extends StatefulWidget {
  const _UserLogIn({Key? key}) : super(key: key);

  @override
  State<_UserLogIn> createState() => _UserLogInState();
}

class _UserLogInState extends State<_UserLogIn> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _submit() {
    if (_formKey.currentState!.validate()) {
      if (_email.text.trim() == 'pyajfoundation0211@gmail.com' &&
          _password.text.trim() == 'Pyaj0211@') {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim());
        Navigator.pushReplacementNamed(context, '/adddata');
      }else{
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Admin not found')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
      if (state == InternetState.Lost) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Waiting for Internet',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screensize.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            height: 30,
                            child: Text(
                              "User",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            height: 30,
                            child: Text(
                              "Admin",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 2) {
                            Navigator.pushReplacementNamed(context, "/admin");
                          } else if (value == 1) {
                            Navigator.pushReplacementNamed(context, "/login");
                          }
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screensize.width * 0.31,
                      top: screensize.height * 0.1),
                  child: Image.asset(
                    'assets/img/login.png',
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screensize.width * 0.38,
                      top: screensize.height * 0.31),
                  child: Text('Admin',
                      style: GoogleFonts.roboto(
                          color: Colors.grey.shade900,
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: screensize.height * .4, right: 35, left: 35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 4),
                              ),
                              label: const Text('Email'),
                              labelStyle:
                                  TextStyle(color: Colors.grey.shade700),
                              hintText: "Enter the Email",
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black26,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (_email.text.trim().isEmpty ||
                                !_email.text.trim().contains('@gmail.com')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade700),
                                hintText: "Enter the Password",
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.black26,
                                ),
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
                              validator: (value) {
                                if (_password.text.trim().isEmpty ||
                                    _password.text.trim().length < 8) {
                                  return 'Password length must be 8 character';
                                }
                                return null;
                              },
                              obscureText: visibility,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black54, fontSize: 15),
                                ))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(screensize.width * 0.01),
                            child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                    onPressed: _submit,
                                    child: const Text('Login')))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

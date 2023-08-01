import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voloc/views/screens/register_screen.dart';
import 'package:voloc/views/screens/tab_screen.dart';
import '../../logic/bloc/login/login_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose;
}
  _hundalgooglebtn() {
    _signInWithGoogle().then((User) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const TabScreen();
        },
      ));
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
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
              child: Image.asset('assets/img/login.png',height: 170,width: 170,fit: BoxFit.cover,),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screensize.width * 0.35, top: screensize.height * 0.31),
              child: Text('Welcome',
                  style: GoogleFonts.roboto(
                    color: Colors.grey.shade900,
                    fontSize: 35,
                    fontWeight: FontWeight.w500
                  )),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 350, right: 35, left: 35),
                child: Column(
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        String? error;
                        if (state is LoginEmailInvalidState) {
                          error = state.error;
                        }
                        return TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 4),
                              ),
                              errorText: error,
                              label: const Text('Email'),
                              labelStyle:  TextStyle(color: Colors.grey.shade700),
                              hintText: "Enter the Email",
                              prefixIcon: const Icon(Icons.email_outlined,color: Colors.black26,)),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginEmailChangedEvent(email: _email.text));
                          },
                        );
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){ }, child: Text('Forgot Password?',style: GoogleFonts.roboto(color: Colors.black54,fontSize: 15),))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(screensize.width * 0.01),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextButton(
                                onPressed: () async{
                                  if (state is LoginValidState) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginSubmitEvent(
                                            email: _email.text,
                                            password: _password.text));
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                            const TabScreen()));
                                  }
                                },
                                child: Text('LOGIN',style: GoogleFonts.roboto(fontSize: 20,color: const Color(0xE2EAF5FF),fontWeight: FontWeight.w500),));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                              'Or Login with',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _hundalgooglebtn();
                      },
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/google.png',
                              width: 35,
                              height: 35,
                            ),
                           const  SizedBox(width: 20,),
                            Image.asset(
                              'assets/icons/github.png',
                              width: 35,
                              height: 35,
                            ),
                            const  SizedBox(width: 20,),
                            Image.asset(
                              'assets/icons/linkedin.png',
                              width: 35,
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Don't have an Account ? ",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.aBeeZee(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),
                            )),
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

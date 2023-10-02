import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voloc/logic/bloc/signup/bloc/sign_up_bloc.dart';

import '../../logic/cubit/internet/cubit/internet_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(),
          ),
          BlocProvider(
            create: (context) => InternetCubit(),
          ),
        ],
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

  File? imageFile;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _mobileno.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
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
                    height: screensize.height * .25,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screensize.width * 0.31,
                        top: screensize.height * 0.1),
                    child: Image.asset(
                      'assets/img/signup.png',
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        //left: screensize.width * 0.2,
                        top: screensize.height * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Create Account',
                            style: GoogleFonts.roboto(
                                color: Colors.grey.shade900,
                                fontSize: 35,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 310, right: 35, left: 35),
                    child: Column(
                      children: [
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 80);

                                imageFile = File(pickedImage!.path);
                                // ignore: use_build_context_synchronously
                                BlocProvider.of<SignUpBloc>(context).add(SignUpFieldChangeEvent(email: _email.text, password: _password.text, selectedImage: imageFile, number: _mobileno.text, username: _username.text));
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade400,
                                foregroundImage: imageFile != null
                                    ? FileImage(imageFile!)
                                    : null,
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            );
                            
                          },
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: ((context, state) {
                            if(state is SignUpUserPhotoInvalidState){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }else{
                              return const SizedBox();
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if(state is SignUpUserNameInvalidState){
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(width: 4),
                                  ),
                                  label: const Text('Username'),
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  hintText: "Enter the Username",
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    color: Colors.black26,
                                  ),
                                  errorText: error),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if(state is SignUpNumberInvalidState){
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _mobileno,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(width: 4),
                                  ),
                                  label: const Text('Mobile no'),
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  hintText: "Enter the Mobile no",
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.black26,
                                  ),errorText: error),
                              keyboardType: TextInputType.number,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if(state is SignUpEmailInvalidState){
                              error = state.error;
                            }
                            return TextField(
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
                                  errorText: error,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black26,
                                  )),
                              keyboardType: TextInputType.emailAddress,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if(state is SignUpPasswordInvalidState){
                              error = state.error;
                            }
                            bool visibility = true;
                            if (state is PassVisibilityState) {
                              visibility = state.isOn;
                            }
                            return TextField(
                              controller: _password,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(width: 4),
                                ),
                                label: const Text('Password'),
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade700),
                                hintText: "Enter the Password",
                                errorText: error,
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
                                        ? BlocProvider.of<SignUpBloc>(context)
                                            .add(PassVisibilityFalseEvent())
                                        : BlocProvider.of<SignUpBloc>(context)
                                            .add(PassVisibilityTrueEvent());
                                  },
                                ),
                              ),
                              obscureText: visibility,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                            child: BlocConsumer<SignUpBloc, SignUpState>(
                              listener: (context, state) {
                                if(state is SignUpSubmitState){
                                  Navigator.pushReplacementNamed(context, '/tab');
                                }else if (state is ErrorState) {
                                      showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Text(
                                          state.error!),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Okay"))
                                      ],
                                    );
                                  });
                                    }
                              },
                              builder: (context, state) {
                                return TextButton(
                                  onPressed: () {
                                    BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                      selectedImage: imageFile,
                                        username: _username.text,
                                        number: _mobileno.text,
                                        email: _email.text,
                                        password: _password.text,
                                        ));
                                    if (state is SignUpValidState) {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                          SignUpSubmitEvent(
                                              selectedImage: imageFile,
                                              username: _username.text,
                                              number: _mobileno.text,
                                              email: _email.text,
                                              password: _password.text,));
                                    } 
                                  },
                                  child: BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: (context, state) {
                                      if(state is SignUpLoadingState){
                                        FocusScope.of(context).unfocus();
                                        return const CircularProgressIndicator();
                                      }
                                       return Text(
                                        'Sign up',
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: const Color(0xE2EAF5FF),
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an Account ? ',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

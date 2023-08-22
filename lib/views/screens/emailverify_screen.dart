import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voloc/logic/bloc/signup/bloc/sign_up_bloc.dart';

class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc()..add(EmailVerificationEvent()),
      child: const _EmailVerifyScreen(),
    );
  }
}

class _EmailVerifyScreen extends StatefulWidget {
  const _EmailVerifyScreen();

  @override
  State<_EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<_EmailVerifyScreen> {
  @override
  void initState() {
    BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is EmailVerificationState){
          Navigator.pushReplacementNamed(context,'/login');
        }
      },
      child: Container(),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please verify your email',
                style: TextStyle(fontSize: 28),
              ),
            ),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<SignUpBloc>(context)
                          .add(EmailVerificationEvent());
                      await Future.delayed(const Duration(seconds: 5));
                    },
                    child: const Text('Resend Email'));
              },
            ),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Cancel')),
          ],
        ),
      ),
    );
  }
}

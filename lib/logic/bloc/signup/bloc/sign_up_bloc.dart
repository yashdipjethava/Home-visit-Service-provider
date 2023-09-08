import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpFieldChangeEvent>((event, emit) {
      try {
        if (event.selectedImage == null) {
          emit(SignUpUserPhotoInvalidState(error: 'Please upload your photo'));
        } else if (event.username.isEmpty || event.username.length < 4) {
          emit(SignUpUserNameInvalidState(error: 'Enter valid username'));
        } else if (event.number.length != 10) {
          emit(
              SignUpNumberInvalidState(error: 'Mobile No. has only 10 digits'));
        } else if (event.email.isEmpty || !event.email.contains('@gmail.com')) {
          emit(SignUpEmailInvalidState(error: 'Enter valid email'));
        } else if (event.password.isEmpty || event.password.length < 8) {
          emit(SignUpPasswordInvalidState(
              error: 'Password must be 8 character'));
        } else {
          emit(SignUpValidState());
        }
      } catch (ex) {
        debugPrint(ex.toString());
      }
    });

    on<PassVisibilityFalseEvent>(
      (event, emit) {
        emit(PassVisibilityState(isOn: false));
      },
    );

    on<PassVisibilityTrueEvent>(
      (event, emit) {
        emit(PassVisibilityState(isOn: true));
      },
    );

    on<EmailVerificationEvent>((event, emit) async {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    });

    on<SignUpSubmitEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState());
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.email!, password: event.password!);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(event.selectedImage!);

        final imageUrl = await storageRef.getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': event.username,
          'email': event.email,
          'number': event.number,
          'image': imageUrl
        });
        emit(SignUpSubmitState());
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          emit(ErrorState(error: error.message));
        }
      }
    });
  }
}

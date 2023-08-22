part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpFieldChangeEvent extends SignUpEvent {
  SignUpFieldChangeEvent(
      {required this.email,
      required this.password,
      required this.selectedImage,
      required this.number,
      required this.username});
  String email;
  String password;
  String number;
  String username;
  File? selectedImage;
}

class SignUpSubmitEvent extends SignUpEvent {
  SignUpSubmitEvent(
      {required this.email,
      required this.password,
      required this.selectedImage,
      required this.username,
      required this.number});
  String? email;
  String? password;
  File? selectedImage;
  String? username;
  String? number;
}

class EmailVerificationEvent extends SignUpEvent {}

class PassVisibilityFalseEvent extends SignUpEvent {}

class PassVisibilityTrueEvent extends SignUpEvent {}

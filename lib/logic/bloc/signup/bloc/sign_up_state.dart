part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpValidState extends SignUpState {}

class SignUpEmailInvalidState extends SignUpState {
  SignUpEmailInvalidState({required this.error});
  String error;
}

class SignUpPasswordInvalidState extends SignUpState {
  SignUpPasswordInvalidState({required this.error});
  String error;
}

class SignUpNumberInvalidState extends SignUpState {
  SignUpNumberInvalidState({required this.error});
  String error;
}

class SignUpUserNameInvalidState extends SignUpState {
  SignUpUserNameInvalidState({required this.error});
  String error;
}

class SignUpUserPhotoInvalidState extends SignUpState {
  SignUpUserPhotoInvalidState({required this.error});
  String error;
}

class SignUpLoadingState extends SignUpState {}

class SignUpSubmitState extends SignUpState {}

class PassVisibilityState extends SignUpState {
  PassVisibilityState({required this.isOn});
  bool isOn;
}



class ErrorState extends SignUpState {
  ErrorState({this.error});
  String? error;
}

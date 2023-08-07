part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidState extends LoginState{}

class LoginEmailInvalidState extends LoginState{
  LoginEmailInvalidState({required this.error});
  String error;
}

class LoginPasswordInvalidState extends LoginState{
  LoginPasswordInvalidState({required this.error});
  String error;
}

class LoginSubmitState extends LoginState{}

class PassVisibilityState extends LoginState{
   PassVisibilityState({required this.isOn});
  bool isOn;
}

class LoginLoadingState extends LoginState{}

class ErrorState extends LoginState{
  ErrorState({required this.error});
  String error;
}
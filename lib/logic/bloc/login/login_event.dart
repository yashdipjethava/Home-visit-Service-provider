part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginFieldChangedEvent extends LoginEvent{
  LoginFieldChangedEvent({required this.email,required this.password});
  String? email;
  String? password;
}

class LoginSubmitEvent extends LoginEvent{
  LoginSubmitEvent({required this.email,required this.password});
  String? email;
  String? password;
}

class LoginWithGoogleEvent extends LoginEvent{}

class PassVisibilityFalseEvent extends LoginEvent{  }

class PassVisibilityTrueEvent extends LoginEvent{  }
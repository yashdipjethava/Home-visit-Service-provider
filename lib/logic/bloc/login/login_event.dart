part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEmailChangedEvent extends LoginEvent{
  LoginEmailChangedEvent({required this.email});
  String? email;
}

class LoginPasswordChangedEvent extends LoginEvent{
  LoginPasswordChangedEvent({required this.password});
  String? password;
}

class LoginSubmitEvent extends LoginEvent{
  LoginSubmitEvent({required this.email,required this.password});
  String? email;
  String? password;
}

class PassVisibilityFalseEvent extends LoginEvent{  }

class PassVisibilityTrueEvent extends LoginEvent{  }
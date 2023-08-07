part of 'user_bloc.dart';

abstract class UserEvent{
  const UserEvent();
}

class LoadUserEvent extends UserEvent{}

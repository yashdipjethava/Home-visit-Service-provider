part of 'user_bloc.dart';

class UserState extends Equatable {

  const UserState({this.isLoading = false, this.error, this.userModel});
  final bool isLoading;
  final UserModel? userModel;
  final String? error;
  
  UserState copyWith({
    bool? isLoading,
    UserModel? userModel,
    String? error,
  }){
    return UserState(
      userModel: userModel ?? this.userModel,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error
    );
  }
  @override
  List<Object?> get props => [userModel,isLoading,error];
}

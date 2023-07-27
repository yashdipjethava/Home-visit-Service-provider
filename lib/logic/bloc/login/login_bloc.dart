import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEmailChangedEvent>((event, emit) {
      if(event.email!.isEmpty || event.email?.trim() == null || !event.email!.contains('@')){
        emit(LoginEmailInvalidState(error: 'Enter valid email'));
      }
      else{
        emit(LoginValidState());
      }
    });

    on<LoginPasswordChangedEvent>((event, emit) {
      if(event.password!.isEmpty || event.password!.trim().length < 8){
        emit(LoginPasswordInvalidState(error: 'Password must be 8 character'));
      }
      else{
        emit(LoginValidState());
      }
    });

    on<PassVisibilityFalseEvent>((event, emit){
      emit(PassVisibilityState(isOn: false));
    },);

    on<PassVisibilityTrueEvent>((event, emit){
      emit(PassVisibilityState(isOn: true));
    },);

    on<LoginSubmitEvent>((event, emit) {
      emit(LoginSubmitState());
    });
  }
}

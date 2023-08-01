import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voloc/logic/bloc/login/login_bloc.dart';


class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child:  const _UserLogIn(),
      ),
    );
  }
}

class _UserLogIn extends StatefulWidget {
   const _UserLogIn();

  @override
  State<_UserLogIn> createState() => _UserLogInState();
}

class _UserLogInState extends State<_UserLogIn> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  void _onSignup(){
    Navigator.pushNamed(context, '/signup');
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  final loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              'Hey there, Welcome back',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: loginKey,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      String? error;
                      if (state is LoginEmailInvalidState) {
                        error = state.error;
                      }
                      return TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 4),
                            ),
                            errorText: error,
                            label: const Text('Email'),
                            prefixIcon: const Icon(Icons.email)),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          BlocProvider.of<LoginBloc>(context).add(LoginEmailChangedEvent(email: _email.text));
                        },
                        
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      String? error;
                      bool visibility = true;
                      if(state is LoginPasswordInvalidState){
                        error = state.error;
                      }
                      if(state is PassVisibilityState){
                        visibility = state.isOn;
                      }
                      return TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 4),
                          ),
                          errorText: error,
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(icon: Icon(visibility ? Icons.visibility : Icons.visibility_off),onPressed: (){
                            visibility ? BlocProvider.of<LoginBloc>(context).add(PassVisibilityFalseEvent()) : BlocProvider.of<LoginBloc>(context).add(PassVisibilityTrueEvent());
                          },),
                        ),
                        obscureText: visibility,
                        onChanged: (value){
                          BlocProvider.of<LoginBloc>(context).add(LoginPasswordChangedEvent(password: _password.text));
                        },

                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(onPressed: () {
                        if(state is LoginValidState){
                          BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(email: _email.text, password: _password.text));
                          Navigator.pushNamed(context, '/tab');
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid credentials')));
                      }, child: const Text('LogIn'));
                    },
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have account yet?',style: TextStyle(fontSize: 18,),),
              TextButton(onPressed: _onSignup, child: Text('Sign Up',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontWeight: FontWeight.bold),))
            ],
          )
        ],
      ),
      
    );
    
  }
}

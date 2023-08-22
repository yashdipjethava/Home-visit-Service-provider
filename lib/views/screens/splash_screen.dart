import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      final user = FirebaseAuth.instance.currentUser;
      if(user == null){
        Navigator.pushReplacementNamed(context, '/onboarding');
      }else{
        Navigator.pushReplacementNamed(context, '/tab');
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Stack(
           children: [
             Image.asset("assets/icons/logo.png",height: 200,width: 200,),
             Padding(
               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.18,top: MediaQuery.of(context).size.width*0.43,right: MediaQuery.of(context).size.width*0.18),
               child: AnimatedTextKit(
                 animatedTexts: [
                   WavyAnimatedText('Voloc',textStyle: const TextStyle(color: Colors.white,fontSize: 22)),
                 ],
                 isRepeatingAnimation: true,
                 totalRepeatCount: 3,
               )
             ),
           ],
         )
        ],
        ),
      ),
    );
  }
}
//
//
// DropdownButton(
// focusColor: Colors.white,
// iconEnabledColor: Colors.white,
// iconDisabledColor: Colors.white,
// isDense: true,
// value: defaultval,
// items: [
// DropdownMenuItem(
// child: Text("User"),
// value: 'User',
// ),
// DropdownMenuItem(
// child: Text("Admin"),
// value: 'Admin',
// ),
// ],
// onChanged: (String? value) {
// setState(() {
// defaultval = value.toString();
// });
// },
// ),

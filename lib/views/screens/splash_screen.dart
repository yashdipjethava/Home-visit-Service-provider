import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voloc/views/screens/admin/admin_tab_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;
      if(user == null){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        bool seen = (preferences.getBool('seen') ?? false);

        if(seen){
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/login');
        }else{
          await preferences.setBool('seen', true);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
        
      }else{
        if(FirebaseAuth.instance.currentUser!.email == 'pyajfoundation0211@gmail.com'){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const AdminTab()));
        }else{
          Navigator.pushReplacementNamed(context, '/tab');
        }
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
             Center(child: Column(
               children: [
                 Image.asset("assets/icons/logo.png",height: 200,width: 200,),
                 AnimatedTextKit(
               animatedTexts: [
                 WavyAnimatedText('ServeEasy',textStyle: const TextStyle(color: Colors.white,fontSize: 22)),
               ],
               isRepeatingAnimation: true,
               totalRepeatCount: 3,
             ),
               ],
             )),
             
           ],
         )
        ],
        ),
      ),
    );
  }
}

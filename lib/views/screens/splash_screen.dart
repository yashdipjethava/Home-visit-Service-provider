import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:voloc/views/screens/onbording_screen2.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnBoardingScreen(),));
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

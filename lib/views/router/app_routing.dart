// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:voloc/views/screens/emailverify_screen.dart';
=======
import 'package:voloc/views/screens/Admin_screen.dart';
>>>>>>> 712881cfc20c5d81e2b903154d8879472aaa2f3d
import 'package:voloc/views/screens/home_screen.dart';
import 'package:voloc/views/screens/login_screen.dart';
import 'package:voloc/views/screens/onbording_screen.dart';
import 'package:voloc/views/screens/profile_screen.dart';
import 'package:voloc/views/screens/search_screen.dart';
import 'package:voloc/views/screens/splash_screen.dart';
import 'package:voloc/views/screens/tab_screen.dart';

import '../screens/signup_screen.dart';


class AppRouting{
  
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_)=>const LogInScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_)=>const ProfileScreen());
      case '/search':
        return MaterialPageRoute(builder: (_)=>const SearchScreen());
      case '/tab':
        return MaterialPageRoute(builder: (_)=>const TabScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_)=>const SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_)=>const HomeScreen());  
      case '/onboarding':
        return MaterialPageRoute(builder: (_)=>const OnBoardingScreen());
      case '/booking':
        return MaterialPageRoute(builder: (_)=>const SignUpScreen());
<<<<<<< HEAD
      case '/emailverify':
        return MaterialPageRoute(builder: (_) => const EmailVerifyScreen());
=======
      case '/admin':
        return MaterialPageRoute(builder: (_)=>const AdminScreen());
>>>>>>> 712881cfc20c5d81e2b903154d8879472aaa2f3d
      default:
        return null;
    }
  }
}
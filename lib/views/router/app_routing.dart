// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:voloc/views/screens/home_screen.dart';
import 'package:voloc/views/screens/login_screen.dart';
import 'package:voloc/views/screens/profile_screen.dart';
import 'package:voloc/views/screens/search_screen.dart';
import 'package:voloc/views/screens/tab_screen.dart';

import '../screens/signup_screen.dart';


class AppRouting{
  
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> HomeScreen());
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
      default:
        return null;
    }
  }
}
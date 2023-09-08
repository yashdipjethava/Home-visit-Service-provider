//This is dummy file and will be deleted

import 'package:flutter/material.dart';
import '../../views/screens/profile_screen.dart';

final List<dynamic> list =[
  { 'title' : 'HOME','icon': Icons.home , 'page' : const ProfileScreen()},
  { 'title' : 'CHAT','icon': Icons.chat ,'page' : const ProfileScreen()},
  { 'title' : 'ABOUT','icon': Icons.info ,'page' : const ProfileScreen()},
];



class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/all.json',
    'Need Servicer',
    'When you need service like Docter \n, Teacher , Electrician , Plumber etc..\n for visiting Home use this application , \nwe\'ll hook you up with exclusive \ncoupons.',
  ),
  OnboardingModel(
    'assets/service.json',
    'How To Use',
    'When you need this then you can \n create your account and just send  this messages \n  for perticular servicer you needed',
  ),
  OnboardingModel(
    'assets/chat.json',
    'How To Connect',
    'When you have To need more detail  \n of servicer then you can chat with him',
  ),
];
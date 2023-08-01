import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/views/screens/login_screen.dart';
import 'package:voloc/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const LogInScreen(),
        theme: theme,
        darkTheme: darkTheme,
        );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voloc/views/router/app_routing.dart';
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
    final appRouting = AppRouting();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        onGenerateRoute: appRouting.onGenerateRoute,
        );
  }
}

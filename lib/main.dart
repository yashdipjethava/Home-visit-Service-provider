import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/views/router/app_routing.dart';
import 'package:voloc/views/screens/admin/add_data_screen.dart';
import 'package:voloc/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _appRouter =  AppRouting();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AddData(),
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: theme,
      darkTheme: darkTheme,
    );
  }
}

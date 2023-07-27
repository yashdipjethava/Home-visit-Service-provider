import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/views/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => TabIndexCubit(),
          child: const TabScreen(),
        ),

        theme: theme,
        darkTheme: darkTheme,
        );
  }
}

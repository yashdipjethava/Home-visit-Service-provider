import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';
import 'package:voloc/views/router/app_routing.dart';
import 'package:voloc/views/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouting();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const LogInScreen(),
        theme: theme,
        darkTheme: darkTheme,
        onGenerateRoute: _appRouter.onGenerateRoute,
        );
  }
}

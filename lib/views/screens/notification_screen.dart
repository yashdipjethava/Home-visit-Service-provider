import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         toolbarHeight: 45,
          title: const Text('Notification'),
         backgroundColor: kColorScheme.onSecondary,
       ),
    );
  }
}

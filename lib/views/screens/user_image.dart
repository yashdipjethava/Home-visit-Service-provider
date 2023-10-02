import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Picture"),
        backgroundColor: Colors.orange,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(image,fit: BoxFit.contain,),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:voloc/core/themes/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: 120,
              height: 120,
              child: Icon(Icons.person),
            ),
            const SizedBox(height: 10),
            const Text(
              'Peter Parker',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const Text(
              'peterparker123@gmail.com',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Edit profile')),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 0.1),
            const SizedBox(height: 02),

            //menu
            profileMenuWidget(
                title: "Settings", icon: Icons.settings, onpress: () {}),
            profileMenuWidget(
                title: "Billing Details", icon: Icons.wallet, onpress: () {}),
            profileMenuWidget(
                title: "My profile",
                icon: Icons.lock_person_rounded,
                onpress: () {}),
            const Divider(thickness: 0.1),
            const SizedBox(height: 10),
            profileMenuWidget(
                title: "About us", icon: Icons.info_outline, onpress: () {}),
            profileMenuWidget(
                title: "Log out",
                icon: Icons.logout,
                textcolor: Colors.red,
                endIcon: false,
                onpress: () {}),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class profileMenuWidget extends StatelessWidget {
  const profileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: kColorScheme.inversePrimary.withOpacity(0.8),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textcolor)),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  size: 15.0, color: Colors.black))
          : null,
    );
  }
}
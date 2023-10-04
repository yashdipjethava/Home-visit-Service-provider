import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:voloc/views/screens/admin/add_data_screen.dart';
import 'package:voloc/views/screens/admin/admin_service_up_delete.dart';

import 'admin_booking_screen.dart';

class AdminTab extends StatefulWidget {
  const AdminTab({super.key});

  @override
  State<AdminTab> createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  int _selectedIndex = 0;
  String title = "Add Data";

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = const AdminBookingScreen();
    if (_selectedIndex == 0) {
      currentScreen = const AddData();
      title = "Add Data";
    }
    if (_selectedIndex == 1) {
      currentScreen = const AdminBookingScreen();
      title = "Bookings";
    }
    if (_selectedIndex == 2) {
      currentScreen = const AdminSerUpDelete();
      title = "All Services";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Row(
              children: [
                  Icon(Icons.logout,color: Colors.white),
                Text("Logout",style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
      body: currentScreen,
      bottomNavigationBar: GNav(
        backgroundColor: Colors.blue,
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.add,
            text: "ADD DATA",
          ),
          GButton(
            icon: Icons.list,
            text: "Bookings",
          ),
          GButton(
            icon: Icons.list_alt,
            text: "Services",
          ),
        ],
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

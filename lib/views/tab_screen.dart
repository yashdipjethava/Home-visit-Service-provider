import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:voloc/views/booking_screen.dart';
import 'package:voloc/views/home_screen.dart';
import 'package:voloc/views/profile_screen.dart';
import 'package:voloc/views/search_screen.dart';

import '../bloc/cubit/tab_index_cubit.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();
    
    return BlocBuilder<TabIndexCubit, TabIndexState>(
      builder: (context, state) {
        if (state.index == 0) {
      activeScreen = const HomeScreen();
    } else if (state.index == 1) {
      activeScreen = const SearchScreen();
    } else if (state.index == 2) {
      activeScreen = const BookingScreen();
    } else if (state.index == 3) {
      activeScreen = const ProfileScreen();
    }
        return Scaffold(
          appBar: AppBar(
            title: const Text('VoLoc'),
            backgroundColor: Colors.black45,
          ),
          body: activeScreen,
          bottomNavigationBar: BlocBuilder<TabIndexCubit, TabIndexState>(
            builder: (context, state) {
              return Container(
                color: Colors.black45,
                child: GNav(
                  tabs: const [
                    GButton(
                        icon: 
                          Icons.home,
                        text: 'Home',
                        backgroundColor: Colors.black45,
                        ),
                    GButton(
                        icon: Icons.search,
                        text: 'Search',
                        backgroundColor: Colors.black45),
                    GButton(
                        icon:Icons.book_online,
                        text: 'Booking',
                        backgroundColor: Colors.black45),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                      backgroundColor: Colors.black45
                    ),
                  ],
                  selectedIndex: state.index,
                  onTabChange: (value) {
                    BlocProvider.of<TabIndexCubit>(context).changeTab(value);
                    value = state.index;
                  },
                  iconSize: 24,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

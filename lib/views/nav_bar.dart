import 'package:flutter/material.dart';
import 'package:movie_app/views/movie_screen.dart';
import 'package:movie_app/views/profile_screen.dart';
import 'package:movie_app/views/tv_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = const [
    MovieScreen(),
    TVScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items:  [
          SalomonBottomBarItem(
            icon: Image.asset('assets/images/home.png',width: 25,height: 25,color: Colors.white,),
            title: const Text("Home"),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: Image.asset('assets/images/tv.png',width: 25,height: 25,color: Colors.white,),
            title: const Text("TV"),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: Image.asset('assets/images/user.png',width: 25,height: 25,color: Colors.white,),
            title: const Text("Profile"),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
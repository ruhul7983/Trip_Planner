import 'package:flutter/material.dart';
import 'package:trip_planner/screens/bottomNavScreen/favourite.dart';
import 'package:trip_planner/screens/bottomNavScreen/homepage.dart';

import '../main.dart';
import 'bottomNavScreen/profile.dart';
import 'bottomNavScreen/postTrip.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pages = [HomePage(), Favorite(), postTrip(), Profile()];
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.white,
          currentIndex: _currentindex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: 'Favourite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline), label: 'Trip'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          }),
      body: _pages[_currentindex],
    );
  }
}

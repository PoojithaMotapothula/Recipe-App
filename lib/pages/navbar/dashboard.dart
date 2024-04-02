// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:receptoria1/pages/navbar/favorites.dart';
import 'package:receptoria1/pages/navbar/accounts.dart';
import 'package:receptoria1/pages/navbar/tips.dart';

import 'homescreen.dart'; 

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    Homescreen(),
    CookingTipsPage(),
    FavoriteRecipesList(),
    Accounts()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: GNav(
          rippleColor: Colors.grey,
          hoverColor: Colors.blueGrey,
          gap: 5,
          curve: Curves.easeInCubic,
          activeColor: Colors.black,
          iconSize: 30,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabBackgroundColor: Colors.white70,
          color: Colors.black,
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: LineIcons.home,
              iconActiveColor: Colors.teal[300],
              text: "Home",
              textColor: Colors.teal.shade300,
            ),
            GButton(
              icon: Icons.tips_and_updates_outlined,
              iconActiveColor: Colors.teal[300],
              text: 'Tips',
              textColor: Colors.teal.shade300,
            ),
            GButton(
              icon: LineIcons.heart,
              iconActiveColor: Colors.teal[300],
              text: 'Favorite',
              textColor: Colors.teal.shade300,
            ),
            GButton(
              icon: LineIcons.user,
              iconActiveColor: Colors.teal[300],
              text: "Account",
              textColor: Colors.teal.shade300,
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Homescreen Content"),
    );
  }
}

class StoresTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Stores Content"),
    );
  }
}

class WishlistTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Wishlist Content"),
    );
  }
}

class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Accounts '),
    );
  }
}

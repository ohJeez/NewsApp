import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/screens/homepage.dart';
import 'package:newsapp/screens/saved_article.dart';
import 'package:newsapp/screens/trending.dart';
import 'package:newsapp/screens/loginscreen.dart';
import 'package:newsapp/screens/signupscreen.dart';

Widget drawermenu(BuildContext context, bool isLoggedIn, Function(bool) onLoginStatusChange) {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      children: [
        DrawerHeader(
          child: Image.asset("assets/images/NN_logo.png", height: double.infinity),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
            );
          },
          title: Row(
            children: [
              Icon(Icons.home_filled),
              SizedBox(width: 10),
              Text('Home'),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SavedArticle()),
            );
          },
          title: Row(
            children: [
              Icon(Icons.bookmark_border_rounded),
              SizedBox(width: 10),
              Text('Saved Articles'),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TrendingPage()),
            );
          },
          title: Row(
            children: [
              Icon(Icons.trending_up_rounded),
              SizedBox(width: 10),
              Text('Trending'),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 10),
              Text('Settings'),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            if (isLoggedIn) {
              // Log out
              onLoginStatusChange(false);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Loginscreen(onLoginStatusChange: onLoginStatusChange)),
                    (Route<dynamic> route) => false,
              );
            } else {
              // Navigate to login screen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Loginscreen(onLoginStatusChange: onLoginStatusChange)),
              );
            }
          },
          title: Row(
            children: [
              Icon(isLoggedIn ? Icons.logout : Icons.login_rounded),
              SizedBox(width: 10),
              Text(isLoggedIn ? 'Sign Out' : 'Login'),
            ],
          ),
        ),
      ],
    ),
  );
}
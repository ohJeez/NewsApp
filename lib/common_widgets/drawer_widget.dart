import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/screens/homepage.dart';
import 'package:newsapp/screens/saved_article.dart';
import 'package:newsapp/screens/trending.dart';

Widget drawermenu(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      children: [
        DrawerHeader(
          child: Image.asset("assets/images/NN_logo.png", height: double.infinity),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Home()),
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
      ],
    ),
  );
}

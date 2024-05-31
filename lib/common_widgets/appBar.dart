import 'package:flutter/material.dart';
import 'package:newsapp/common_widgets/SearchDeligate.dart';
import 'package:newsapp/screens/notification_page.dart';

PreferredSizeWidget appBar(BuildContext context, bool isSelected, Function(String) onSearch) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
    ),
    centerTitle: true,
    title: Text('NewsNOW'),
    backgroundColor: Colors.black,
    actions: [
      Row(
        children: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchOperation(onSearch),
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            icon: isSelected ? Icon(Icons.notifications) : Icon(Icons.notifications_none),
          ),
        ],
      ),
    ],
  );
}

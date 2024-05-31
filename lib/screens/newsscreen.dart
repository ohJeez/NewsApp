import 'package:flutter/material.dart';
import 'package:newsapp/common_widgets/appBar.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/common_widgets/newspg.dart';

class Newsscreen extends StatelessWidget {
  final Article article;
  final bool notificationSelected;
  final Function(String) fetchNewsData;

  Newsscreen({
    Key? key, // Use Key? key here
    required this.article,
    required this.notificationSelected,
    required this.fetchNewsData,
  }) : super(key: key); // Pass the key parameter to the super constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, notificationSelected, fetchNewsData),
      body: Center(
        child: Mainnews(article: article),
      ),
    );
  }
}

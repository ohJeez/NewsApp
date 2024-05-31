import 'package:flutter/material.dart';
import 'package:newsapp/common_widgets/Build_Text_Widget.dart';
import 'package:newsapp/common_widgets/News_Display_List.dart';
import 'package:newsapp/common_widgets/appBar.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/common_widgets/newspg.dart';

class SavedArticle extends StatelessWidget {
  const SavedArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, false, (String query) => {}),
      body: Column(
        children: [
          BuildTextWidget(text: 'Saved Articles'),
          Expanded(
            child: Mainnews.savedArticles.isNotEmpty
                ? NewsList(
              GetNewsResponseModel(
                totalArticles: Mainnews.savedArticles.length,
                articles: Mainnews.savedArticles,
              ),
            )
                : Center(child: Text('No Saved Articles')),
          ),
        ],
      ),
    );
  }
}

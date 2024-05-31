import 'package:flutter/material.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/screens/newsscreen.dart';

Widget NewsList(GetNewsResponseModel getNewsResponseModel) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: ListView.builder(
      itemCount: getNewsResponseModel.articles?.length ?? 0,
      itemBuilder: (context, index) {
        final article = getNewsResponseModel.articles![index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Newsscreen(article: article,notificationSelected: false,fetchNewsData: (p0) {},), // Pass the article object
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              ListTile(
                selectedColor: Colors.black12,
                contentPadding: EdgeInsets.all(4.0),
                title: Text(article.title ?? 'No title'),
                leading: article.image != null ? Image.network(article.image!) : null,
              ),
            ],
          ),
        );
      },
    ),
  );
}

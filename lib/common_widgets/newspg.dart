import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:share/share.dart'; // Import the share package

class Mainnews extends StatefulWidget {
  final Article article;
  static List<Article> savedArticles = []; // List to store saved articles

  const Mainnews({Key? key, required this.article}) : super(key: key);

  @override
  _MainnewsState createState() => _MainnewsState();
}

class _MainnewsState extends State<Mainnews> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = Mainnews.savedArticles.contains(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.article.image != null)
                Image.network(widget.article.image!),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(widget.article.publishedAt!),
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(widget.article.url ?? '');
                        },
                      ),
                      IconButton(
                        icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                            if (isBookmarked) {
                              Mainnews.savedArticles.add(widget.article);
                            } else {
                              Mainnews.savedArticles.remove(widget.article);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.article.title ?? 'No title',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                widget.article.description ?? 'No description',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                widget.article.content ?? 'No content',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

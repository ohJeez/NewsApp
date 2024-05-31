import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/common_widgets/appBar.dart';
import 'package:newsapp/common_widgets/drawer_widget.dart';
import 'package:newsapp/models/news_article.dart';
import 'package:newsapp/screens/homepage.dart';
import 'package:newsapp/notification/localnotification.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(NewsArticleAdapter());

  // Open a Hive box
  await Hive.openBox<NewsArticle>('newsBox');

  // Initialize local notifications
  LocalNotificationService.initialize(); // Add this line

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool notificationSelected = false;

  Future<void> fetchNewsData(String query) async {
    // Fetch news data and store it in Hive
    var newsBox = Hive.box<NewsArticle>('newsBox');

    final response = await Dio().get(
      'https://gnews.io/api/v4/search',
      queryParameters: {
        'q': query,
        'lang': 'en',
        'country': 'us',
        'max': 1,
        'apikey': 'your_api_key',
      },
    );

    if (response.statusCode == 200) {
      final articles = response.data['articles'];
      if (articles.isNotEmpty) {
        final article = articles[0];
        final newsArticle = NewsArticle()
          ..title = article['title']
          ..description = article['description'];

        await newsBox.add(newsArticle);

        // Show local notification
        LocalNotificationService.showNotification(newsArticle.title, newsArticle.description);
      }
    } else {
      print('Failed to fetch news data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, notificationSelected, fetchNewsData),
        drawer: drawermenu(context),
        body: Homepage(), // Placeholder for the body content
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/common_widgets/Build_Text_Widget.dart';
import 'package:newsapp/common_widgets/News_Display_List.dart';
import 'package:newsapp/common_widgets/appBar.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/notification/localnotification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GetNewsResponseModel getNewsResponseModel = GetNewsResponseModel();
  bool isLoading = false;

  static const String apiKey = 'efbc0360012e7dd8d6788469f878a871';
  static const String apiUrl = 'https://gnews.io/api/v4/search';

  @override
  void initState() {
    super.initState();
    fetchData();
    Timer.periodic(Duration(minutes: 30), (timer) => fetchData());
  }

  Future<void> fetchData([String query = 'breaking news']) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await Dio().get(apiUrl, queryParameters: {
        'q': query,
        'lang': 'en',
        'country': 'us',
        'max': 10,
        'apikey': apiKey,
      });

      final articles = response.data['articles'];
      if (articles.isNotEmpty) {
        final article = articles[0];
        final title = article['title'];
        final description = article['description'];

        LocalNotificationService.showNotification(title, description);
        setState(() {
          getNewsResponseModel = GetNewsResponseModel.fromJson(response.data);
        });
      }
    } catch (e) {
      print('Failed to fetch news data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, true, (String query) => fetchData(query)),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.black),
      )
          : Column(
        children: [
          BuildTextWidget(text: 'LATEST NEWS'),
          Expanded(
            child: NewsList(getNewsResponseModel),
          ),
        ],
      ),
    );
  }
}
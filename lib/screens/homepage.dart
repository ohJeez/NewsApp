import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/common_widgets/Build_Text_Widget.dart';
import 'package:newsapp/common_widgets/News_Display_List.dart';
import 'package:newsapp/common_widgets/swipe_widget.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/common_widgets/category_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GetNewsResponseModel getNewsResponseModel = GetNewsResponseModel();
  bool isLoading = false;
  bool notificationSelected = false;
  String selectedCategory = "Crime";

  @override
  void initState() {
    super.initState();
    fetchNewsData(selectedCategory);
  }

  fetchNewsData(String category) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Dio().get(
          'https://gnews.io/api/v4/search?q=$category&lang=en&country=us&max=10&apikey=efbc0360012e7dd8d6788469f878a871');
      setState(() {
        getNewsResponseModel = GetNewsResponseModel.fromJson(response.data);
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch news data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )
          : Column(
        children: [
          SwipeWidget(
            borderRadius: BorderRadius.zero,
            apiUrl: 'https://gnews.io/api/v4/search?q=example&lang=en&country=us&max=10&apikey=efbc0360012e7dd8d6788469f878a871',
          ),
          BuildTextWidget(text: 'TOP PICKS FOR YOU'),
          Categorylist(
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
                fetchNewsData(category);
              });
            },
          ),
          Expanded(
            child: NewsList(getNewsResponseModel,),
          ),
        ],
      ),
    );
  }
}

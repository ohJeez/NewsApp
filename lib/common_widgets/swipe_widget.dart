import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/common_widgets/newspg.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';
import 'package:newsapp/screens/newsscreen.dart'; // Import your model

class SwipeWidget extends StatefulWidget {
  final BorderRadius borderRadius;
  final String apiUrl;

  SwipeWidget({Key? key, required this.borderRadius, required this.apiUrl}) : super(key: key);

  @override
  State<SwipeWidget> createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fetchData();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final response = await Dio().get(widget.apiUrl);
      final newsResponse = GetNewsResponseModel.fromJson(response.data);

      setState(() {
        _articles = newsResponse.articles ?? [];
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < _articles.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: widget.borderRadius,
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _articles.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Newsscreen(article: article,fetchNewsData: (p0) {

                                },notificationSelected: false,),),
                        );
                      },
                      child: Image.network(
                        article.image ?? '',
                        fit: BoxFit.cover,
                        semanticLabel: 'Image ${index + 1}',
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Icon(Icons.broken_image));
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _articles.length,
                          (index) => Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.white : Colors.white30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

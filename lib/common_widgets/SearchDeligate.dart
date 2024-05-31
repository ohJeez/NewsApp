import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/common_widgets/News_Display_List.dart';
import 'package:newsapp/models/Get_News_Response_Models.dart';

class SearchOperation extends SearchDelegate<String> {
  final Function(String) onSearch;
  GetNewsResponseModel getNewsResponseModel = GetNewsResponseModel();

  SearchOperation(this.onSearch);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context); // Display suggestions after clearing the query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    addRecentSearch(query); // Add to recent search list
    return FutureBuilder<void>(
      future: searchNews(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return NewsList(getNewsResponseModel);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? recentSearch
        : recentSearch.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
          trailing: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              recentSearch.remove(suggestions[index]);
              showSuggestions(context); // Refresh the suggestions list
            },
          ),
        );
      },
    );
  }

  Future<void> searchNews(String query) async {
    try {
      final response = await Dio().get(
        'https://gnews.io/api/v4/search',
        queryParameters: {
          'q': query,
          'lang': 'en',
          'country': 'us',
          'max': 10,
          'apikey': 'efbc0360012e7dd8d6788469f878a871',
        },
      );
      getNewsResponseModel = GetNewsResponseModel.fromJson(response.data);
    } catch (e) {
      print('Failed to fetch news data: $e');
    }
  }

  void addRecentSearch(String query) {
    if (query.trim().isNotEmpty && !recentSearch.contains(query))      {
      recentSearch.insert(0, query);
      if (recentSearch.length > 5) {
        recentSearch.removeLast();
      }
    }
  }
}

List<String> recentSearch = []; // This list stores recent search terms

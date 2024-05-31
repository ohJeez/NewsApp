import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categorylist extends StatelessWidget {
  final Function(String) onCategorySelected;

  Categorylist({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Crime",
      "Sports",
      "Film",
      "Technology",
      "National",
      "International"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: categories.map((category) {
            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  category,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

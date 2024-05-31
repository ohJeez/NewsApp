import 'package:flutter/material.dart';

class BuildTextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;

  const BuildTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,15.0,8.0,8.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: fontSize ?? 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
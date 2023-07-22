import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextTitleColorFromUniversity extends StatelessWidget {
  final String text;
  final Color universityColor;

  TextTitleColorFromUniversity({
    Key? key,
    required this.text,
    required this.universityColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: universityColor,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double? rating;
  final IconData iconData;

  const CustomRatingBar({
    Key? key,
    this.rating,
    this.iconData = Icons.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating ?? 0,
      itemBuilder: (context, index) => Icon(
        iconData,
        color: rating != null ? Colors.amber : Colors.grey,
      ),
      itemCount: 5,
      itemSize: 20.0,
      unratedColor: rating != null ? Colors.amber.withAlpha(70) : Colors.grey.withAlpha(70),
      direction: Axis.horizontal,
    );
  }
}


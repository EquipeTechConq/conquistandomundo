import 'package:flutter/cupertino.dart';

import '../../../ultil/colors.dart';

class TextNormalTextGrey extends StatelessWidget {
  final String text;
  const TextNormalTextGrey({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(
      fontSize: 16,
      color: StandardColors.greyDarkColor,
    ),
    );
  }
}

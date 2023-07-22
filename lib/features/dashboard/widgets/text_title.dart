import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ultil/colors.dart';

class TextTitle extends StatelessWidget {
  final String text;
  const TextTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: StandardColors.blueColor,
       ),
    );
  }
}

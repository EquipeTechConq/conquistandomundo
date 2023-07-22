import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ButtonInsideApp extends StatelessWidget {
  final String buttonText;
  final RoundedLoadingButtonController controller;
  final void Function() goNextScreen;
  const ButtonInsideApp({Key? key,
    required this.buttonText,
    required this.goNextScreen,
    required this.controller,
  }) : super(key: key);

  //  Duration duration = const Duration(milliseconds: 500),
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RoundedLoadingButton(
          child: Text(buttonText,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                  fontSize: 14)),
        borderRadius: 10,
          color: Color.fromARGB(255, 255, 0, 0),
              onPressed: goNextScreen,
              controller: controller,
      ),
    );
  }
}

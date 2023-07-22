import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderInputDataLogIn extends StatelessWidget {
  const HeaderInputDataLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double telaTocaDeLayout = 1020.0;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem-Vindo a Plataforma do Conquistando o Mundo!',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w200,
            fontSize: screenWidth > telaTocaDeLayout ? 16 : 14,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'Login',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: screenWidth > telaTocaDeLayout ? 42 : 36,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

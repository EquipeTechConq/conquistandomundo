import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidthPixel = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final double telaTocaDeLayout = 1020.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('/imgLogo.png'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          height: screenHeight / 8,
        ),
        Row(
          children: [
            SizedBox(
              width: 18,
            ),
            Text(
              'Seja bem-vindo a\nplataforma Conquistando o\nMundo.',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: screenWidthPixel > telaTocaDeLayout ? 46 : 36,
                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 18,
            ),
            Text(
              'Preencha os campos ao lado para criar\na sua conta e entrar em nossa plataforma',
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: screenWidthPixel > telaTocaDeLayout ? 24 : 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 37,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280.0,
              width: 400.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage( "/d.png"),
                  fit: BoxFit.fill,
                ),

              ),
            ),
          ],
        ),

      ],
    );
  }
}

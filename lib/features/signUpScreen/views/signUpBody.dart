import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/signUpScreen/views/signUpInputData.dart';
import 'package:plataforma_deploy/features/signUpScreen/views/welcome.dart';
import '../../../ultil/colors.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color background = StandardColors.blueColor;
    const Color fill = StandardColors.whiteColor;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = 45; // fills 45% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          stops: stops,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Welcome(),
          SignUpInputData(),
        ],
      ),
    );
  }
}

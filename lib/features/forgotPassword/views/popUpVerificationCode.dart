import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/logInprovider.dart';
import '../../../ultil/components/loadingButton.dart';

class PopUpVerificationCode extends StatelessWidget {
  PopUpVerificationCode({Key? key}) : super(key: key);

  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider _Provider = context.watch<LogInSignUpProvider>();

    return AlertDialog(
      title: Text('Um email foi enviado para\n${_Provider.resetPasswordEmail.text.trim()},\nclique no link para trocar sua senha',
        textAlign: TextAlign.center ,
        style: TextStyle(color: Color.fromARGB(255, 6, 82, 120),
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 28),
      ),
      actions: [
        ButtonInsideApp(
            buttonText: "ENTENDI",
            goNextScreen: (){
              Navigator.pop(context);
            },
            controller: _buttonController
        )
      ],
    );
  }
}

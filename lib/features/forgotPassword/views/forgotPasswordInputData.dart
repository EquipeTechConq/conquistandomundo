import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/logInprovider.dart';
import '../../../ultil/components/loadingButton.dart';
import '../../../ultil/firebaseAuth.dart';

class ForgotPasswordInputData extends StatelessWidget {
   ForgotPasswordInputData({Key? key}) : super(key: key);
  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();


  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider _Provider = context.watch<LogInSignUpProvider>();

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final formKeyAuthentication = GlobalKey<FormState>();
    final Duration _duration= Duration(microseconds: 2000);
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Container(
        height: screenHeight * .76,
        width: screenWidth / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Form(
          key: formKeyAuthentication,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 12, bottom: 12, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Esqueceu a senha da\nsua conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  'Por favor, digite o seu email abaixo enviaremos\num link para trocar de senha!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    obscureText: false,
                    controller: _Provider.resetPasswordEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        // borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14),
                      hintText: "Confirme sua senha",
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: ButtonInsideApp(
                              buttonText: 'ENVIAR',
                              goNextScreen: () async {
                                await AuthServiceCadasto().resetPassword(_Provider.resetPasswordEmail.text);
                                _Provider.showPopUpVerificationCode(context);
                                _buttonController.reset();
                              },
                              controller: _buttonController,

                            )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextButton(
                        child: const Text("Nao recebeu o email? Clique aqui para reenviar",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                                fontSize: 14,
                                color: Color.fromARGB(255, 118, 117, 117))),
                          onPressed: () async {
                            await AuthServiceCadasto().resetPassword(_Provider.resetPasswordEmail.text);
                            _Provider.showPopUpVerificationCode(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

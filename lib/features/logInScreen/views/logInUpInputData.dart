import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plataforma_deploy/features/watchVideo/choose_subject/home_view.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../ultil/components/loadingButton.dart';
import '../../forgotPassword/viewforgotPasswordScreen.dart';
import '../../../ultil/firebaseAuth.dart';
import 'headerInputDataLogIn.dart';

class LogInUpInputData extends StatelessWidget {
   LogInUpInputData({Key? key}) : super(key: key);

  final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final verificaPasswordController = TextEditingController();
    final formKeyAuthentication = GlobalKey<FormState>();
    final double _heightBetweenFields = 12.0;

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderInputDataLogIn(),
                SizedBox(
                  height: _heightBetweenFields*2,
                ),
                Text(
                  'Digite seu email!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                SizedBox(
                  height: _heightBetweenFields,
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    validator: (emailController) =>
                        !EmailValidator.validate(emailController!)
                            ? 'Digite um email válido'
                            : null,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14),
                        hintText: "Email",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Digite sua senha!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                SizedBox(
                  height: _heightBetweenFields,
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (passwordController) {
                      if (passwordController!.isEmpty ||
                          !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                              .hasMatch(passwordController)) {
                        return "Sua senha deve conter letras minúsculas,maiúsculas e números";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14),
                      hintText: "Senha",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: _heightBetweenFields,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        child: Text("Esqueceu a senha?",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 118, 117, 117))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ViewForgotPasswordScreen()));
                        }),
                  ],
                ),
                SizedBox(
                  height: _heightBetweenFields*2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                            height: 40,
                            child: ButtonInsideApp(
                              buttonText: 'ENTRAR',
                              goNextScreen: () async {
                              final form = formKeyAuthentication.currentState!;
                              if (form.validate()) {
                                await AuthServiceCadasto().loginUser(
                                    emailController.text,
                                    passwordController.text
                                );
                                Navigator.push(
                                  context,
                                  // MaterialPageRoute(builder: (context) => const  ViewDashboard(),),
                                  MaterialPageRoute(builder: (context) => const  Home(),),
                                );
                              }
                              _buttonController.reset();
                            },
                              controller: _buttonController,
                        )
                      ),
                  ],
                ),
                SizedBox(
                  height: _heightBetweenFields,
                ),
                // TextButton(
                //     child: Text("Ainda não possui uma conta?",
                //         style: TextStyle(
                //             fontSize: 12,
                //             color: Color.fromARGB(255, 118, 117, 117))),
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => const ViewSignUpScreen()));
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

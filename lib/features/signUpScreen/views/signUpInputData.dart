import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plataforma_deploy/features/signUpScreen/views/screen_verify_email.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/logInprovider.dart';
import '../../../ultil/components/loadingButton.dart';
import '../../logInScreen/viewLogInScreen.dart';
import '../../../ultil/firebaseAuth.dart';
import 'headerInputData.dart';

class SignUpInputData extends StatelessWidget {
   SignUpInputData({Key? key}) : super(key: key);

   final RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final primeiroNomeController = TextEditingController();
    final segundoNomeController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final verificaPasswordController = TextEditingController();
    final formKeyAuthentication = GlobalKey<FormState>();
    const double _heightBetweenFields = 12.0;

    LogInSignUpProvider logInSignUpProvider = LogInSignUpProvider();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderInputData(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Digite o Primeiro Nome!',
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
                        width: screenWidth/7.6,
                        child: TextFormField(
                          validator: (primeiroNomeController) =>
                          primeiroNomeController == null
                              ? 'Digite um email válido'
                              : null,
                          controller: primeiroNomeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 14),
                              hintText: "Primeiro Nome",
                              fillColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Digite seu Sobrenome!',
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
                        width: screenWidth/7.6,
                        child: TextFormField(
                          validator: (segundoNomeController) =>
                          segundoNomeController == null
                              ? 'Digite um email válido'
                              : null,
                          controller: segundoNomeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 14),
                              hintText: "Sobrenome",
                              fillColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                Text(
                  'Confirme sua senha!',
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
                    controller: verificaPasswordController,
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
                SizedBox(
                  height: _heightBetweenFields*2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: ButtonInsideApp(
                              buttonText: 'CADASTRAR',
                              goNextScreen: () async {
                              final form = formKeyAuthentication.currentState!;
                              if (form.validate() &&
                                  verificaPasswordController.text ==
                                      passwordController.text) {

                                await AuthServiceCadasto().registerUser(
                                    emailController.text,
                                    passwordController.text,
                                    primeiroNomeController.text,
                                    segundoNomeController.text,
                                );
                                await logInSignUpProvider.sendEmailVerification();
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const  ScreenMandarVerificacaoDeEmail(),),
                                );
                              }
                              _buttonController.reset();
                            },
                              controller: _buttonController,
                            )
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _heightBetweenFields,
                ),
                TextButton(
                    child: Text("Já possui uma conta?",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 118, 117, 117))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ViewLogInScreen()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

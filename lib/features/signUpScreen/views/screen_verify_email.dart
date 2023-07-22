import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/dashboard/view_dashboard_screen.dart';
import 'package:plataforma_deploy/ultil/components/loadingButton.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../providers/logInprovider.dart';

class ScreenVerifyEmail extends StatefulWidget {
  const ScreenVerifyEmail({Key? key}) : super(key: key);

  @override
  State<ScreenVerifyEmail> createState() => _ScreenVerifyEmailState();
}

class _ScreenVerifyEmailState extends State<ScreenVerifyEmail> {
  LogInSignUpProvider logInSignUpProvider = LogInSignUpProvider();
  RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ViewDashboard()),
        );
        controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.email, size: 200, color: Colors.black,),
              Text("Verifique seu email para continuar", style: TextStyle(fontSize: 20),),
              Text("Nós enviamos um link para verificação de email para você.\nPor favor clique naquele link para verificar o seu email", style: TextStyle(fontSize: 20),),
              Text("Após verificar clique em continuar:", style: TextStyle(fontSize: 20),),
              ButtonInsideApp(
                buttonText: 'Continuar',
                goNextScreen: () {
                  if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewDashboard()),
                    );
                    controller.reset();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor verifique seu email'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    setState(() {});
                  }
                  controller.reset();
                },
                controller: controller,
              ),
              TextButton(
                child: Text(
                  "Mandar Link novamente",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 118, 117, 117),
                  ),
                ),
                onPressed: () {
                  logInSignUpProvider.sendEmailVerification();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ScreenMandarVerificacaoDeEmail extends StatefulWidget {
  const ScreenMandarVerificacaoDeEmail({Key? key}) : super(key: key);

  @override
  State<ScreenMandarVerificacaoDeEmail> createState() => _ScreenMandarVerificacaoDeEmailState();
}

class _ScreenMandarVerificacaoDeEmailState extends State<ScreenMandarVerificacaoDeEmail> {
  RoundedLoadingButtonController controller =  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Clique no botão abaixo para enviar link\npara enviar o link de verificão de email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            ButtonInsideApp(
              buttonText: 'Enviar link',
              goNextScreen: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenVerifyEmail()),
                );
                controller.reset();
              },
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}


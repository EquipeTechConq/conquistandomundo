import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/signUpScreen/views/signUpBody.dart';


class ViewSignUpScreen extends StatelessWidget {
  const ViewSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpBody(),
    );
  }
}
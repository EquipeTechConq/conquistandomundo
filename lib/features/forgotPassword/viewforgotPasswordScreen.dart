import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/forgotPassword/views/forgotPasswordBody.dart';

class ViewForgotPasswordScreen extends StatelessWidget {
  const ViewForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordBody(),
    );
  }
}
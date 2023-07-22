import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/logInScreen/views/logInBodyBody.dart';

class ViewLogInScreen extends StatelessWidget {
  const ViewLogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogInBody(),
    );
  }
}
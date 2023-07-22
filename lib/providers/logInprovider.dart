import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../features/forgotPassword/views/popUpVerificationCode.dart';

class LogInSignUpProvider with ChangeNotifier {

  static final LogInSignUpProvider provider = LogInSignUpProvider._internal();

  factory LogInSignUpProvider() {
    return provider;
  }

  LogInSignUpProvider._internal();


  Future showPopUpVerificationCode(context) => showDialog(
    context: context,
    builder: (context) => PopUpVerificationCode(),
  );

  bool isChecked = false;

  void updateIsCheck(){
    isChecked = !isChecked;
  }


  final TextEditingController resetPasswordEmail = TextEditingController();


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getUserId() async {
    final User? user = await auth.currentUser;
    final userId = user?.uid.toString();
    return userId;
  }
/*  Future<void> saveDataFirebase() async {
    await firestore.collection('userData').doc(await getUserId()).set({
      'Name': nameController.text,
      'ChestCircumference': 'ChestCircumference',
      'Age': 'Age',
      'Ethnicity': 'Ethnicity',
      'Gender': 'Gender',
      'Height': 'Height',
      'HipCircumference': 'HipCircumference',
      'WaistCircumference': 'WaistCircumference',
      'Weight': 'Weight',
      'Email': 'Email',
      'UserId': 'UserId',
    }
    );
  }*/
  Future<void> sendEmailVerification() async {
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      await user!.sendEmailVerification();
    }
    catch(e){
      print(e);
    }

  }


}



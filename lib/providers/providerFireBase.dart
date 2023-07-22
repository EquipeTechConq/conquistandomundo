import 'package:flutter/cupertino.dart';

class ProviderFireBase with ChangeNotifier {

  static final ProviderFireBase provider = ProviderFireBase._internal();

  factory ProviderFireBase() {
    return provider;
  }
  ProviderFireBase._internal();



}
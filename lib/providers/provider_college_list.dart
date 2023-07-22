import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderCollegeList with ChangeNotifier {

  static final ProviderCollegeList provider = ProviderCollegeList._internal();

  factory ProviderCollegeList() {
    return provider;
  }

  ProviderCollegeList._internal();

  final List<Map<String, dynamic>> colleges = [
    {'name': 'Harvard University','logo': 'assets/harvard.png','alias': 'Harvard','location': 'Cambridge','image':'assets/harvard_campus.jpg','color': Color(0xFFA41034),'sat': '1520','rate': '5.01%','coa': '75,914'},
    {'name': 'University of Florida','logo': 'assets/Uf.png','alias': 'UF','location': 'Gainsville','image':'assets/Ufc.jpeg','color': Color(0xFFFA4616),'sat': '1360','rate': '30.63%','coa': '27,150'},
    {'name': 'University of South Florida','logo': 'assets/Usf.png','alias': 'USF','location': 'Tampa','image':'assets/Usf_campus.jpg','color': Color(0xFF006747),'sat': '1256','rate': '49.24%','coa': '21,134'},
    {'name': 'Florida Atlantic University','logo': 'assets/Fau.png','alias': 'FAU','location': 'Boca Raton','image':'assets/Fau_campus.jpg','color': Color(0xFF003366),'sat': '1147','rate': '74.78%','coa': '21,761'},
    {'name': 'Drexel University','logo': 'assets/drexel.png','alias': 'Drexel','location': 'Philadelphia','image':'assets/drexelc.jpg','color':Color(0xFF07294D),'sat': '1272','rate': '82.89%','coa': '78,761'},
    {'name': 'University of Kentucky','logo': 'assets/uk.png','alias': 'UK','location': 'Lexington','image':'assets/ukc.jpg','color': Color.fromARGB(255, 29, 25, 130),'sat': '1170','rate': '94.69%','coa': '40,763'},
    {'name': 'Northwestern','logo': 'assets/Northwestern.png','alias': 'Northwestern','location': 'Evanston','image':'assets/Northwestern_campus.jpg','color': Color(0xFF4E2A84),'sat': '1505','rate': '9.31%','coa': '78,654'},
    {'name': 'Stetson University','logo': 'assets/st.png','alias': 'Stetson','location': 'Gulfport','image':'assets/stc.jpg','color': Color(0xFF006747),'sat': '1120','rate': '91.67%','coa': '38,490'},
    {'name': 'Rice University','logo': 'assets/rice.png','alias': 'Rice','location': 'Houston','image':'assets/ricec.jpg','color': Color(0xFF00205B),'sat': '1510','rate': '9.5%','coa': '78,204'},
  ];





}



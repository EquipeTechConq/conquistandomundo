import 'package:flutter/material.dart';

import '../../../ultil/get_name.dart';
import '../widgets/text_normal_text.dart';
import '../widgets/text_title.dart';
import '../widgets/widget_student_data.dart';


class StudentDataView extends StatefulWidget {
  const StudentDataView({super.key});

  @override
  State<StudentDataView> createState() => _StudentDataViewState();
}


class _StudentDataViewState extends State<StudentDataView> {
  String name = '';
  String last_name = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    name = (await GetUserName().get_name());
    last_name = (await GetUserName().get_segundo_nome());
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           const TextTitle(text: "Perfil",),

           WidgetStudentData(
             imagePath: 'assets/teste-2.jpg',
             name: '${last_name}, ${name}',
             title: 'Bem-vindo,',
             shapeImage: BoxShape.circle,
           ),
          Divider(),
          WidgetStudentData(
             imagePath: 'assets/harvard.png',
             name: 'Harvard',
             title: 'My Dream School',
             shapeImage: BoxShape.rectangle,
           ),
           Divider(),
           WidgetStudentData(
             imagePath: 'assets/ranking.png',
             name: '#69',
             title: 'Raking',
             shapeImage: BoxShape.circle,
           ),
        ],
      ),
    );
  }
}
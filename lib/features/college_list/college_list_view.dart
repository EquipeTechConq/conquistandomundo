import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/college_list/view/app_bar_widget.dart';
import 'package:plataforma_deploy/features/college_list/view/college_list_body.dart';

class CollegeListView extends StatelessWidget {
  const CollegeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: AppBarWidget(),
      ),
      body: CollegeListBody(),
    );
  }
}
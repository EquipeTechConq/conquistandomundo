import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/dashboard/views/dashboard_body.dart';


class ViewDashboard extends StatelessWidget {
  const ViewDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashboardBody(),
    );
  }
}
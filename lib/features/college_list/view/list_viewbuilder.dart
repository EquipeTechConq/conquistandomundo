import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/provider_college_list.dart';
import 'list_widget.dart';

class ListViewBuilder extends StatefulWidget {
  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {


  @override
  Widget build(BuildContext context) {
    final ProviderCollegeList _provider = context.watch<ProviderCollegeList>();

    List<Map<String, dynamic>> colleges = _provider.colleges;

    return ListView.builder(
      itemCount: colleges.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: ListWidget(
            campusPicturePath: colleges[index]['image'],
            universityName: colleges[index]['name'],
            acceptanceRate: colleges[index]['rate'],
            costOfAttendance: colleges[index]['coa'],
            averageSATScore: colleges[index]['sat'],
            alias: colleges[index]['location'],
            logo: colleges[index]['logo'],
            universityColor: colleges[index]['color'],
          ),
        );
      },
    );
  }
}

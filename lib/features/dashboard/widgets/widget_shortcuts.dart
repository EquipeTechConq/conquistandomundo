import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/dashboard/widgets/text_title.dart';

import '../../../ultil/colors.dart';

class WidgetShortcuts extends StatelessWidget {
  final String title;
  final IconData icone;

  const WidgetShortcuts({Key? key, required this.title, required this.icone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 148,
          decoration: BoxDecoration(
            color: Color(0xff543ec4),
            borderRadius: BorderRadius.circular(26),
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Text( title, style: TextStyle(color: Colors.white, fontSize: 20),),
            Icon(
                icone, size: 80,
                color:StandardColors.whiteColor
            ),
            ],
          ),
        ),
    );
  }
}

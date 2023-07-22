import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetIsExpanded extends StatefulWidget {
  final double screenWidth;
  const WidgetIsExpanded({Key? key, required this.screenWidth}) : super(key: key);

  @override
  State<WidgetIsExpanded> createState() => _WidgetIsExpandedState();
}

class _WidgetIsExpandedState extends State<WidgetIsExpanded> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 0, left: 0.0, right: 0.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 400,
          width: widget.screenWidth,
          //width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text('data')
            
            ],
          ),
        ),
      ),
    );
  }
}

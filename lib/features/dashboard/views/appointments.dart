import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("You don't have any tasks today", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffD00104)),),
          Opacity(
            opacity: 0.7,
            child: Container(
              height: 300,
              width: 330,
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image_searching.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
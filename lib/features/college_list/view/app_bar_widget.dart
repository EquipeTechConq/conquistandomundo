import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ultil/colors.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: StandardColors.blueColor,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.02,
              child: InkWell(
                child: Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: StandardColors.whiteColor,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                 Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: screenWidth *.36-12,
            ),
            Container(
              width: screenWidth *.18,
              child: const Text(
                'My College List',
                style: TextStyle(
                  fontSize: 20,
                  color:  StandardColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: screenWidth *.18-12,
            ),
            Container(
              width: screenWidth * 0.20,
              child: InkWell(
                child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.text_snippet_outlined,
                        color: StandardColors.whiteColor,
                        size: 40,
                      ),
                      Text(
                        'Refazer o teste',
                        style: TextStyle(
                          fontSize: 18,
                          color:  StandardColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                onTap: () {
                  print('oi');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

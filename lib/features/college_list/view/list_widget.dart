import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/college_list/view/widget_isexpanded.dart';
import '../../../ultil/colors.dart';
import '../grey_text.dart';
import '../text_color_from_university.dart';


class ListWidget extends StatefulWidget {
  final String campusPicturePath;
  final String universityName;
  final String acceptanceRate;
  final String costOfAttendance;
  final String averageSATScore;
  final String alias;
  final String logo;
  final Color universityColor;

  ListWidget({Key? key,
     required this.campusPicturePath,
     required this.universityName,
     required this.acceptanceRate,
     required this.costOfAttendance,
     required this.averageSATScore,
     required this.alias,
     required this.logo,
    required this.universityColor,
   }) : super(key: key);
  @override
  _ListWidgetState createState() => _ListWidgetState();
}
class _ListWidgetState extends State<ListWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 0, left: 12.0, right: 12.0),
      child: Stack(

        children: [
          isExpanded
              ? WidgetIsExpanded(screenWidth: screenWidth,)
              : SizedBox(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            elevation: 8,
            child: Container(
              height: 100,
              child: Stack(
                children: [


                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      height: 100,
                      //width: screenWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.campusPicturePath),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitleColorFromUniversity(text: widget.universityName, universityColor: widget.universityColor,),
                        TextNormalTextGrey(text: widget.alias),
                      ],
                    ),
                      SizedBox(width: screenWidth/20,),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitleColorFromUniversity(text: widget.acceptanceRate, universityColor: widget.universityColor,),
                        TextNormalTextGrey(text: "Acceptance rate"),
                      ],
                    ),
                      SizedBox(width: screenWidth/20,),

                      Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitleColorFromUniversity(text: '\$'+widget.costOfAttendance, universityColor: widget.universityColor,),
                        TextNormalTextGrey(text: "Cost of attendance"),
                      ],
                    ),
                      SizedBox(width: screenWidth/20,),

                      Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitleColorFromUniversity(text: widget.averageSATScore+' points', universityColor: widget.universityColor,),
                        TextNormalTextGrey(text: 'Average SAT score'),
                      ],
                    ),

                  ],
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: StandardColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: Image.asset(
                                        widget.logo,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/triangle.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                // Row(
                //   children: [
                //     SizedBox(width: screenWidth - 189),
                //     InkWell(
                //       child: Container(
                //         height: 100,
                //         width: 125,
                //         decoration: BoxDecoration(
                //           color: StandardColors.whiteColor,
                //           borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(20),
                //             bottomRight: Radius.circular(20),
                //           ),
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               isExpanded
                //                   ? Icons.keyboard_arrow_up_rounded
                //                   : Icons.keyboard_arrow_down_rounded,
                //               color: StandardColors.blueColor,
                //                                 size: 60,
                //                 ),
                //               ],
                //             ),
                //           ),
                //     onTap: () {
                //       // setState(() {
                //       //   isExpanded = !isExpanded;
                //       //     });
                //         },
                //       ),
                //     ],
                //   ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

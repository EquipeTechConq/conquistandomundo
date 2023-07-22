import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterVideoInformation extends StatefulWidget {
  final String channelName;
  final String channelPicture;
  final String videoName;
  const FooterVideoInformation({Key? key,
    required this.channelName,
    required this.channelPicture,
    required this.videoName
  }) : super(key: key);

  @override
  _FooterVideoInformationState createState() => _FooterVideoInformationState();
}

class _FooterVideoInformationState extends State<FooterVideoInformation> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left:8, top: 16.0, right: 16.0),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 90,
          width: (_screenWidth*964/1440)-10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                            image: AssetImage('assets/ImageLogo.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 16,),
                      Text(
                        widget.videoName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

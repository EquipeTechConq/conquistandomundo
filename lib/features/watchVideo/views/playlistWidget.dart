import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistWidget extends StatefulWidget {
  final String imageUrl;
  final String textVideo;
  final String nameProfessor;
  const PlaylistWidget({Key? key, required this.imageUrl, required this.textVideo, required this.nameProfessor,}) : super(key: key);

  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Container(
          height: 100,
          width: (_screenWidth/1440*202) -34,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 2),
            ],
            image: DecorationImage(
              image: NetworkImage( widget.imageUrl),

              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15),

        Flexible(
          child: SizedBox(
            width:( _screenWidth/1440*202)-20,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 165.0,
                maxHeight: 60.0,
              ),
              child: Text(
                widget.textVideo,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
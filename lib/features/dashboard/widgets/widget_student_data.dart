import 'package:flutter/cupertino.dart';
import 'package:plataforma_deploy/features/dashboard/widgets/text_normal_text.dart';
import 'package:plataforma_deploy/features/dashboard/widgets/text_title.dart';

class WidgetStudentData extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String title;
  final BoxShape shapeImage;
  WidgetStudentData({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.title,
    required this.shapeImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8,),

        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath!),
              fit: BoxFit.fill,
            ),
            shape: shapeImage,
          ),
        ),
        const SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextNormalText(text: title),
            TextTitle(text: name),
          ],
        )
      ],
    );
  }
}


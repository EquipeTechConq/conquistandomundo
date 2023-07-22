import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/college_list/college_list_view.dart';
import '../../calendario/calendario.dart';
import '../../watchVideo/choose_subject/home_view.dart';
import '../widgets/widget_shortcuts.dart';

class ShortcutsView extends StatelessWidget {
  const ShortcutsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CollegeListView()),
                  );
                },
                child: WidgetShortcuts(
                  title: "Chat-GPT",
                  icone: Icons.logo_dev_rounded,
                ),
              ),
            ),

          SizedBox(width: 8,),

            Expanded(
              child: GestureDetector(
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CollegeListView()),
                  );
                },
                child: WidgetShortcuts(
                  title: "Colleges",
                  icone:  Icons.book,
                ),
              ),
            ),

        ],),

          SizedBox(height: 8,),

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewCalendar()),
                  );
                },
                child: WidgetShortcuts(
                  title: "Calendar",
                  icone:  Icons.calendar_today,
                ),
              ),
            ),
              SizedBox(width: 8,),

            Expanded(
              child: GestureDetector(
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: WidgetShortcuts(
                  title: "Classes",
                  icone:  Icons.my_library_books_rounded,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
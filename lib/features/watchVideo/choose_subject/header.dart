import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/logInScreen/viewLogInScreen.dart';
import '../../../ultil/firebaseAuth.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AppBar(
        backgroundColor: const Color(0xff0B1423),
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.asset("assets/imgLogo.png"),
                const SizedBox(
                  width: 50,
                ),

                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(40.0), // Adjust the border radius as per your preference
                //       ),
                //     ),
                //   ),
                //   child:  Padding(
                //     padding: EdgeInsets.all(4.0),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.home_filled,
                //           size: 36.0,
                //           color: Colors.white,
                //         ),
                //         SizedBox(width: 4,),
                //         Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                //       ],
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const NewCalendar()),
                //     );
                //   },
                //   style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(40.0), // Adjust the border radius as per your preference
                //       ),
                //     ),
                //   ),
                //   child:  Padding(
                //     padding: EdgeInsets.all(4.0),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.calendar_today,
                //           size: 36.0,
                //           color: Colors.white,
                //         ),
                //         SizedBox(width: 4,),
                //         Text('Calendar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                //       ],
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const CollegeListView()),
                //     );
                //   },
                //   style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(40.0), // Adjust the border radius as per your preference
                //       ),
                //     ),
                //   ),
                //   child:  Padding(
                //     padding: EdgeInsets.all(4.0),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.book,
                //           size: 36.0,
                //           color: Colors.white,
                //         ),
                //         SizedBox(width: 4,),
                //         Text('Colleges', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(
                  width: 100,
                ),

                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewLogInScreen()),
                    );
                    await AuthServiceCadasto().signOut();
                  },
                  child:  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          size: 36.0,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4,),
                        Text('Log Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        toolbarHeight: 70,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

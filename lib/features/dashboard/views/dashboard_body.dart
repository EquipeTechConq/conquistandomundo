import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plataforma_deploy/features/dashboard/views/shortcuts.dart';
import 'package:plataforma_deploy/features/dashboard/views/student_data.dart';
import '../../../ultil/colors.dart';
import '../../../ultil/firebaseAuth.dart';
import '../../logInScreen/viewLogInScreen.dart';
import 'appointments.dart';


class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color background = StandardColors.blueColor;
    const Color fill = StandardColors.greyColor;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    const double fillPercent = 60;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          stops: stops,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              height: screenHight*0.4,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/campus_princeton.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
          children: [
            SizedBox(
              height: screenHight*0.4,
              child: Column(
                children: [
                  SizedBox(height: screenHight*0.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: screenWidth*.02,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:screenWidth*.125,
                                    height: screenHight*0.15,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/logo_completa.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth*.24,),

                                ],
                              ),
                              SizedBox(
                                height: screenHight*0.12,
                              ),
                               Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 52,
                                  color: StandardColors.whiteColor,
                                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width:screenWidth*.2,
                            height: screenHight*0.32,
                            // decoration: const BoxDecoration(
                            //   image: DecorationImage(
                            //     image: AssetImage('/image_dashboard.png'),
                            //     fit: BoxFit.fill,
                            //   ),
                            //   shape: BoxShape.rectangle,
                            // ),
                          ),
                          SizedBox(width: screenWidth*.24,),

                            Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                },
                                child: const Icon(
                                  Icons.notification_add,
                                  size: 28,
                                  color: StandardColors.whiteColor,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(width: screenWidth*.02,),

                          Container(
                            width:screenWidth*.08,
                            child:InkWell(
                              onTap: () async {
                                await AuthServiceCadasto().signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ViewLogInScreen()),
                                );
                              },
                              child:  Row(
                                children: [
                                  Text('Log Out', style: TextStyle(
                                    fontSize: 18,
                                    color: StandardColors.whiteColor,
                                    fontFamily: GoogleFonts.ubuntu().fontFamily,),),
                                   SizedBox(width: 8),
                                   const Icon(
                                    Icons.login,
                                    size: 28.0,
                                     color: StandardColors.whiteColor,
                                  ),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                  SizedBox(width: screenWidth*.02,),
                ],
              ),

            ),
            Stack(
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    height: screenHight*0.6,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Ny.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
             SizedBox(
                height: screenHight*0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 12.0, left: 12.0),
                        child: SizedBox(
                          height: screenHight*0.48,
                            child: const ShortcutsView()
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            height: screenHight*0.48,
                            child: const AppointmentView()
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            height: screenHight*0.48,
                            child: const StudentDataView(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    ],
                  ),
                ),
               ],
             ),
            ],
          ),
        ]
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'home.dart';
import '../../../ultil/firebaseAuth.dart';

Future<String?> getUserMentorStatus() async {

  AuthServiceCadasto authService = AuthServiceCadasto();
  String? userId = await authService.getUserId();

  // try {
  //   DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(userId)
  //       .get();

  //   if (userSnapshot.exists) {
  //     Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  //     String mentorStatus = userData['mentor'] ?? "false";
  //     return mentorStatus;
  //   } else {
  //     // User document not found
  //     return "false";
  //   }
  // } catch (e) {
  //   // Error occurred while fetching user data
  //   print('Error: $e');
  //   return "false";
  // }
  return userId;
}

class Home extends StatefulWidget {
  @override
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => building();
}

class building extends State<Home> {
  int widgetId = 1;

  Widget Modulo1(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    const double telaTocaDeLayout = 1150.0;

    return Row(
      children: [
        HomeItemBuilder(context, 'assets/Mdulo21.png', "Application"),
        SizedBox(
          width: width < telaTocaDeLayout ? 75 : 90,
        ),
        HomeItemBuilder(context, 'assets/Mdulo31.png', "Math"),
        SizedBox(
          width: width < telaTocaDeLayout ? 75 : 90,
        ),
        HomeItemBuilder(context, 'assets/Mdulo41.png', "English"),
        SizedBox(
          width: width < telaTocaDeLayout ? 75 : 90,
        ),
        HomeItemBuilder(context, 'assets/Mdulo52.png', "Essays"),
      ],
    );
  }

  Widget Modulo2(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    const double telaTocaDeLayout = 1150.0;
    return Container(
      child: Row(
        children: [
          HomeItemBuilder(context, 'assets/Mdulo62.png', "TOEFL"),
          SizedBox(
            width: width < telaTocaDeLayout ? 75 : 90,
          ),
          HomeItemBuilder(context, 'assets/123.png', "DET"),
          SizedBox(
            width: width < telaTocaDeLayout ? 75 : 90,
          ),
          HomeItemBuilder(context, 'assets/321.png', "Interview"),
          SizedBox(
            width: width < telaTocaDeLayout ? 75 : 90,
          ),

          HomeItemBuilder(context, 'assets/ult.png', "Universities"),
        ],
      ),
    );
  }

  Widget Troca() {
    return widgetId == 1 ? Modulo1(context) : Modulo2(context);
  }

  void _updateWidget() {
    setState(() {
      widgetId = widgetId == 1 ? 2 : 2;
    });
  }

  void _updateWidget2() {
    setState(() {
      widgetId = widgetId == 2 ? 1 : 1;
    });
  }

  // Future<void> getMentor() async {
  //   String status = await getUserMentorStatus();
  // }

  @override
  void initState() {
    // getMentor();
    super.initState();
    getUserMentorStatus().then((userId) {
      print("BUNDA DO USER: $userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Header(),
      ),
      backgroundColor: const Color.fromARGB(255, 6, 18, 32),
      body: Column(
        children: [
          Container(
              width: screenWidth,
              height: screenHeight * .45,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 6, 18, 32),
                image: DecorationImage(
                    image: AssetImage('assets/Desktop1.png'), fit: BoxFit.fill),
              )),
          SizedBox(
            height: screenHeight * .035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox.fromSize(
                size: const Size(36, 36), // button width and height
                child: ClipOval(
                  child: Material(
                    color: const Color.fromARGB(255, 166, 168, 174), // button color
                    child: InkWell(
                      splashColor:
                      Color.fromARGB(255, 142, 142, 142), // splash color
                      onTap: () {
                        _updateWidget2();
                      }, // button pressed
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back,
                          ) // icon
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: Troca(),
              ),
              SizedBox.fromSize(
                size: const Size(36, 36), // button width and height
                child: ClipOval(
                  child: Material(
                    color: const Color.fromARGB(255, 166, 168, 174), // button color
                    child: InkWell(
                      splashColor:
                      const Color.fromARGB(255, 142, 142, 142), // splash color
                      onTap: () {
                        _updateWidget();
                      }, // button pressed
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                          ) // icon
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


/*import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'home.dart';

class Home extends StatefulWidget {
  @override
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => building();
}

class building extends State<Home> {

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetAulas= <Widget>[
      HomeItemBuilder(context, 'assets/Mdulo21.png', "Application"),
      HomeItemBuilder(context, 'assets/Mdulo31.png', "Math"),
      HomeItemBuilder(context, 'assets/Mdulo41.png', "English"),
      HomeItemBuilder(context, 'assets/Mdulo52.png', "Essays"),
      HomeItemBuilder(context, 'assets/Mdulo62.png', "TOEFL"),
      HomeItemBuilder(context, 'assets/123.png', "DET"),
      HomeItemBuilder(context, 'assets/321.png', "Interview"),
      HomeItemBuilder(context, 'assets/ult.png', "Universities"),
    ];


    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Header(),
      ),
      backgroundColor: const Color.fromARGB(255, 6, 18, 32),
      body: Column(
        children: [
          Container(
              width: screenWidth,
              height: screenHeight * .45,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 6, 18, 32),
                image: DecorationImage(
                    image: AssetImage('assets/Desktop1.png'), fit: BoxFit.fill),
              )),
          SizedBox(
            height: screenHeight * .035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             /* SizedBox.fromSize(
                size: const Size(36, 36), // button width and height
                child: ClipOval(
                  child: Material(
                    color: const Color.fromARGB(255, 166, 168, 174), // button color
                    child: InkWell(
                      splashColor:
                      Color.fromARGB(255, 142, 142, 142), // splash color
                      onTap: () {
                        _updateWidget2();
                      }, // button pressed
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back,
                          ) // icon
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
              /*AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: Troca(),
              ),*/
              CarouselSlider(
                  items: _widgetAulas,
                  options: CarouselOptions(
                    height: 400,

                  ),

              ),
              /*SizedBox.fromSize(
                size: const Size(36, 36), // button width and height
                child: ClipOval(
                  child: Material(
                    color: const Color.fromARGB(255, 166, 168, 174), // button color
                    child: InkWell(
                      splashColor:
                      const Color.fromARGB(255, 142, 142, 142), // splash color
                      onTap: () {
                        _updateWidget();
                      }, // button pressed
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                          ) // icon
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          )
        ],
      ),
    );
  }
}
*/

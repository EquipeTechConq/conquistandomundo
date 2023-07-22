import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// import 'package:plataforma_deploy/features/calendario/calendario.dart';
import 'package:plataforma_deploy/features/logInScreen/viewLogInScreen.dart';
import 'package:plataforma_deploy/features/watchVideo/choose_subject/home_view.dart';
// import 'package:plataforma_deploy/providers/providerFireBase.dart';
import 'package:plataforma_deploy/providers/logInprovider.dart';
import 'package:plataforma_deploy/providers/providerPlayVideos.dart';
import 'package:plataforma_deploy/providers/provider_college_list.dart';
import 'package:provider/provider.dart';
// import 'features/college_list/college_list_view.dart';
// import 'features/dashboard/view_dashboard_screen.dart';
// import 'features/forgotPassword/viewforgotPasswordScreen.dart';
// import 'features/signUpScreen/views/screen_verify_email.dart';
// import 'features/watchVideo/viewSignUpScreen.dart';
// import 'features/watchVideo/views/listViewBuilder.dart';
// import 'features/watchVideo/views/playlistWidget.dart';
// import 'features/watchVideo/views/videoPlayer.dart';
// import 'features/youtubePlayer.dart';
import 'ultil/firebaseAuth.dart';
// import 'features/signUpScreen/viewSignUpScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {

  FlutterFFmpeg().execute('-version');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider( create: (context) => LogInSignUpProvider() ,),
          ChangeNotifierProvider( create: (context) => ProviderPlayVideos() ,),
          ChangeNotifierProvider( create: (context) => ProviderCollegeList() ,),
        ],
        child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
            stream: AuthServiceCadasto().firebaseAuth.authStateChanges(),
            builder: (context, AsyncSnapshot snapshot) {
               if (snapshot.hasData) {
                   if(user != null){
                    return  Home();
                  }
                }
              return  ViewLogInScreen();
        }
      )
    );
  }
}

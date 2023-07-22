// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// Future<List<String>> getVideosFromFolder() async {
//   List<String> videos = [];
//   FirebaseStorage storage = FirebaseStorage.instance;
//   Reference folder = storage.ref().child('ESSAY');
//   ListResult result = await folder.listAll();
//   for (var i in result.items) {
//     String videoFolder = await i.getDownloadURL();
//     videos.add(videoFolder);
//   }
//   return videos;
// }

// Future<String> getCurrentVideo() async {
//   List<String> videos = await getVideosFromFolder();
//   return videos.isNotEmpty ? videos[0] : '';
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(
//       debugShowCheckedModeBanner: false,
//       theme: CupertinoThemeData(
//         brightness: Brightness.light,
//       ),
//       title: 'Appinio Video Player Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late VideoPlayerController _videoPlayerController,
//       _videoPlayerController2,
//       _videoPlayerController3;

//   late CustomVideoPlayerController _customVideoPlayerController;
//   late CustomVideoPlayerWebController _customVideoPlayerWebController;

//   final CustomVideoPlayerSettings _customVideoPlayerSettings =
//       const CustomVideoPlayerSettings();

//   late CustomVideoPlayerWebSettings _customVideoPlayerWebSettings;

//   @override
//   void initState() {
//     super.initState();
//     initializeVideoPlayer();
//   }

//   Future<void> initializeVideoPlayer() async {
//   String video = await getCurrentVideo();
//   _customVideoPlayerWebSettings = CustomVideoPlayerWebSettings(
//     src: video,
//     hideDownloadButton: true,
//   );

//   _videoPlayerController = VideoPlayerController.network(video);
//   _videoPlayerController2 = VideoPlayerController.network(video240);
//   _videoPlayerController3 = VideoPlayerController.network(video480);
//   _customVideoPlayerController = CustomVideoPlayerController(
//     context: context,
//     videoPlayerController: _videoPlayerController,
//     customVideoPlayerSettings: _customVideoPlayerSettings,
//     additionalVideoSources: {
//       "240p": _videoPlayerController2,
//       "480p": _videoPlayerController3,
//       "720p": _videoPlayerController,
//     },
//   );

//   _customVideoPlayerWebController = CustomVideoPlayerWebController(
//     webVideoPlayerSettings: _customVideoPlayerWebSettings,
//   );

//   await _videoPlayerController.initialize();
//   await _videoPlayerController2.initialize();
//   await _videoPlayerController3.initialize();
//   setState(() {});
// }

//   @override
//   void dispose() {
//     _customVideoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text("Appinio Video Player"),
//       ),
//       child: SafeArea(
//         child: ListView(
//           children: [
//             kIsWeb
//                 ? Expanded(
//                     child: CustomVideoPlayerWeb(
//                       customVideoPlayerWebController:
//                           _customVideoPlayerWebController,
//                     ),
//                   )
//                 : CustomVideoPlayer(
//                     customVideoPlayerController: _customVideoPlayerController,
//                   ),
//             CupertinoButton(
//               child: const Text("Play Fullscreen"),
//               onPressed: () {
//                 if (kIsWeb) {
//                   _customVideoPlayerWebController.setFullscreen(true);
//                   _customVideoPlayerWebController.play();
//                 } else {
//                   _customVideoPlayerController.setFullscreen(true);
//                   _customVideoPlayerController.videoPlayerController.play();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// String videoUrlLandscape =
//     "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
// String videoUrlPortrait =
//     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
// String longVideo =
//     "https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe";

// String video720 =
//     "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

// String video480 =
//     "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";

// String video240 =
//     "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";

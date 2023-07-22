// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';


// class VideosFirebase extends StatefulWidget {
//   const VideosFirebase({Key? key}) : super(key: key);

//   @override
//   _VideosFirebaseState createState() => _VideosFirebaseState();
// }

// class _VideosFirebaseState extends State<VideosFirebase> {
//   late List<VideoPlayerController> controllers;
//   late List<ChewieController> chewieControllers;

//   @override
//   void initState() {
//     super.initState();
//     controllers = [];
//     chewieControllers = [];
//     initializeControllers();
//   }

//   Future<List<String>> getVideosFromFolder() async {
//     List<String> videos = [];
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference folder = storage.ref().child('ESSAY');
//     ListResult result = await folder.listAll();
//     for (var i in result.items) {
//       String videoFolder = await i.getDownloadURL();
//       videos.add(videoFolder);
//     }
//     return videos;
//   }

//   Future<List<VideoPlayerController>> returnVideos() async {
//     List<VideoPlayerController> controllers = [];
//     List<String> videoUrls = await getVideosFromFolder();

//     print("VIDUSS: $videoUrls");

//     for (String url in videoUrls) {
//       controllers.add(VideoPlayerController.networkUrl(Uri.parse(url)));
//     }

//     print("CONTROLERS: $controllers");

//     return controllers;
//   }

// void initializeControllers() async {
//   List<VideoPlayerController> videoControllers = await returnVideos();

//   for (var controller in videoControllers) {
//     await controller.initialize().then((_) {
//       // After the video is initialized, add it to the list of controllers
//       controllers.add(controller);
//       chewieControllers.add(
//         ChewieController(
//           videoPlayerController: controller,
//           autoPlay: false,
//           looping: false,
//         ),
//       );
//     });
//   }

//   setState(() {});
// }

//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     for (var chewieController in chewieControllers) {
//       chewieController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Video Playlist')),
//       body: _buildVideoPlaylist(),
//     );
//   }

//   Widget _buildVideoPlaylist() {
//     if (controllers.isEmpty) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       return ListView.builder(
//         itemCount: controllers.length,
//         itemBuilder: (context, index) {
//           return Chewie(controller: chewieControllers[index]);
//         },
//       );
//     }
//   }
// }
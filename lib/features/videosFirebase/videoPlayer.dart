import 'dart:typed_data';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:media_kit/media_kit.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';
import 'package:sidebarx/sidebarx.dart';          // Provides [VideoController] & [Video] etc.
// import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:video_compress/video_compress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> getUserMentorStatus(String userId) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      bool mentorStatus = userData['mentor'] ?? false;
      return mentorStatus;
    } else {
      // User document not found
      return false;
    }
  } catch (e) {
    // Error occurred while fetching user data
    print('Error: $e');
    return false;
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Necessary initialization for package:media_kit.
//   MediaKit.ensureInitialized();
//   runApp(
//     const MaterialApp(
//       home: MyScreen(),
//     ),
//   );
// }

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

class VideoData {
  String name;
  Media media;

  VideoData({required this.name, required this.media});
}

Future<List<VideoData>> getVideosFromFolder(String mainFolder) async { // SORT VIDEOS
  // List<Media> videos = [];
  List<VideoData> videosList = [];
  List<String> videoPaths = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  // Reference folder = storage.ref().child('Essays');
  Reference folder = storage.ref().child(mainFolder);
  ListResult result = await folder.listAll();

  print("\nALL SHIT: ${result.prefixes}\n");

  for (var prefix in result.prefixes) {
    String folderPath = prefix.fullPath;
    // Check if the item is a folder
    print("Pica: ${folderPath}");
    // videoPaths.add(folderPath);
    Reference newFolder = storage.ref().child(folderPath);
    ListResult newResult = await newFolder.listAll();

    for (var newItem in newResult.items) {
      // print("MY ITEMS: $newItem");
      String video = newItem.name;
      String videoExtension = newItem.name.toLowerCase();
      if (videoExtension.endsWith(".mp4")) {
        String videoFolder = await newItem.getDownloadURL();
        videosList.add(VideoData(media: Media(videoFolder), name: newItem.name.replaceFirst(".mp4", "")));
      }
    }
  }


  // for (var item in result.items) {
  //   String folderExtension = item.name;
  //   String extensionCheck = item.name.toLowerCase();
  //   print("FOLDERRR: $folderExtension");
  //   if (!extensionCheck.endsWith('.mp4')) {
  //     print("FOLDER EXTENSION:$folderExtension");
  //     Reference newFolder = storage.ref().child("Essay/$folderExtension/");
  //     ListResult newResult = await folder.listAll();      
  //     for (var doc in newResult.items) {
  //       String documentName = doc.name;
  //       if (documentName.endsWith('.mp4')) {
  //         print("MYDOC: $documentName");
  //         String videoFolder = await item.getDownloadURL();
  //         // videos.add(Media(videoFolder));
  //         videosList.add(VideoData(media: Media(videoFolder), name: item.name.replaceFirst(".mp4", "")));
  //       }      
  //     }
  //   }
  // }
  
  return videosList;
}

Future<Widget?> generateThumbnail(String videoPath) async {
  // FlutterFFmpeg().execute('-version');
  final FlutterFFmpeg ffmpeg = FlutterFFmpeg();
  final String thumbnailPath = videoPath.replaceAll('.mp4', '.jpg');

  final int rc = await ffmpeg.execute(
      '-i $videoPath -ss 00:00:01.000 -vframes 1 $thumbnailPath');

  if (rc == 0) {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      thumbnailPath,
      thumbnailPath,
      quality: 50,
    );

    if (compressedImage != null) {
      final image = Image.file(File(compressedImage.path));
      print("NEW THUMBNAIL: $image");
      return image;
    }
  }

  return null; // Placeholder widget if thumbnail generation fails
}

// Future<List<VideoData>> fetchVideos() async {
//   List<VideoData> videoList = await getVideosFromFolder();
//   // await generateThumbnail("https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe");
//   // Use the videoList in your code

//   // for (var video in videoList) {
//   //   var test = video.thumbnail;
//   // }

//   return videoList;
// }

class MyScreen extends StatefulWidget {
  final playlistName;

  const MyScreen({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  late final player = Player();
  late final controller = VideoController(player);
  // late List<Media> playlist = [];
  late List<VideoData> playlist = [];
  int selectedVideoIndex = 0;
  bool mentor = false; // DO: update with user information
  List<Uint8List> documentDataToSend = [];
  List<String> documentLinksToSend = []; // DO: initialize with documents already stored in firebase
  List<String> videoFiles = [];
  List<String> documents = []; // get list from firebase
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<VideoData> videos = [];
  bool isUploading = false;
  bool uploadFailed = false;

  @override
  void initState() {
    initializeVideoList();
    printThumbnail();
    getDocumentsFromServer();
    // getThumbnail("https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe");
    super.initState();
  }

  Future<List<String>> getDocumentsFromFolder(String folderAula) async {
    List<String> documentLinks = [];
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference folder = storage.ref().child('${widget.playlistName}/$folderAula');
    ListResult result = await folder.listAll();

    for (var item in result.items) {
      String documentName = item.name;

      if (!documentName.endsWith('.mp4')) {
        String documentUrl = await item.getDownloadURL();
        documentLinks.add(documentUrl);
      }
    }

    return documentLinks;
  }

  Future<String> getVideoFileName(int videoIndex) async {
    // Reference reference = storage.ref().child(path);
    // String downloadURL = await reference.getDownloadURL();
    Reference folder = storage.ref().child("ESSAY");
    ListResult result = await folder.listAll();

    String videoName = result.items[videoIndex].name.replaceFirst(".mp4", "");

    print("One result: $videoName");

    return videoName;
    // print("URL download: $downloadURL");
    // return downloadURL;
  }

  Future popupUploadVideos(context) => showDialog(
    context: context, 
    builder: ((context) => 
      AlertDialog(
        backgroundColor: const Color.fromARGB(255, 13, 30, 48),
        content: Container(
          width: (MediaQuery.of(context).size.width) / 3,
          // height: 500,
          child: UploadVideos(playlist: widget.playlistName, newVideoIndex: playlist.length + 1,),
        ),
      )
    ));

  Future<String?> generateThumbnail(String videoUrl) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 50,
    );

    // print("MEU PENIS: $thumbnailPath");

    return thumbnailPath ?? '';
  }


  Future<void> printThumbnail() async {
    print("thumfunction");
    String? thumbnailPath = await generateThumbnail("https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe");
    print("Thumbnail Path: $thumbnailPath");
    // Widget? result = await generateThumbnail("https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe");
    // print("NEW THUMBUSSA: $result");
    // getVideoFileName("/ESSAY/DANÇA DO MARCELO CARECA(GURNING GUY RAVE).mp4");
  }

  Future<void> getDocumentsFromServer() async {
    print("PAU GROSSO${playlist[selectedVideoIndex].name}");
    String folder = playlist[selectedVideoIndex].name;
    List<String> newDocuments = await getDocumentsFromFolder(folder);
    setState(() {
      documents = newDocuments;
    });
  }

  Future<List<VideoData>> fetchVideos() async {
    String mainFolder = widget.playlistName;
    List<VideoData> videoList = await getVideosFromFolder(mainFolder);
    // await generateThumbnail("https://firebasestorage.googleapis.com/v0/b/plataforma-conquistando-f33bb.appspot.com/o/ESSAY%2FDAN%C3%87A%20DO%20MARCELO%20CARECA(GURNING%20GUY%20RAVE).mp4?alt=media&token=78e9775a-df21-4d9c-8f77-cb41319c10fe");
    // Use the videoList in your code

    // for (var video in videoList) {
    //   var test = video.thumbnail;
    // }

    return videoList;
  }

  Future<void> initializeVideoList() async {
    List<VideoData> fetchedVideoList = await fetchVideos();

    setState(() {
      playlist = fetchedVideoList;
    });

    if (playlist.isNotEmpty) {
      player.open(playlist[selectedVideoIndex].media);
    }
  }

  void playVideoAtIndex(int index) {
    player.open(playlist[index].media);
    setState(() {
      selectedVideoIndex = index;
    });
  }

  Future<void> handleFileGrupUpload() async {
    // print("VIDEO NAMES: $videoFileNames");
    // print("VIDEO BYTES: ${videoBytesList.length}");

    if (documentDataToSend.isNotEmpty && documentLinksToSend.isNotEmpty) {
      setState(() {
        isUploading = true;
        uploadFailed = false;
      });
      // Perform your video upload logic for each video in the list
      for (int i = 0; i < documentDataToSend.length; i++) {
        Uint8List videoBytes = documentDataToSend[i];
        String videoFileName = documentLinksToSend[i];

        try {
         await handleFileUpload(videoBytes, videoFileName);
        } catch (e) {
          setState(() {
            uploadFailed = true;
          });
          print('Error uploading video: $e');
        }
      }

      setState(() {
        documentDataToSend.clear();
        documentLinksToSend.clear();
      });

      print("PENIS MUITO GROSSO");
      // Clear the selected videos after upload

      // print("VIDEO NAMES: $videoFileNames");
    }
  }

  // compressVideoFile(String videoFilePath) async {
  //   final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePath);

  //   return compressedVideoFilePath!.file;
  // }

  // getThumbnail(String videoFilePath) async {
  //   print("TITSS");  
  //   final path = await compressVideoFile(videoFilePath);
  //   final thumbnail = await VideoCompress.getFileThumbnail(path);

  //   print("THUMBNAIL CU: $thumbnail");
  // }

  Future<void> handleFileUpload(Uint8List file, String fileName) async {
    // Upload the file to Firebase or any other storage
    // Retrieve the document link after successful upload
    String documentLink = 'https://example.com/document.pdf';
    String folder = playlist[selectedVideoIndex].name;

    final folderName = "${widget.playlistName}/$folder"; // Specify the desired folder
    final destinationPath = '$folderName/$fileName';

    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final uploadTask = storageRef.child(destinationPath).putData(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        // documentLinksToSend.add(downloadUrl);
        documents.add(downloadUrl);
      });

      print("Uploaded document link: $downloadUrl");
    } catch (error) {
      print("Failed to upload document: $error");
    }

    // setState(() {
    //   documentLinksToSend.add(documentLink);
    // });
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print("File Resulttt: ");

    if (result != null && result.files.isNotEmpty) {
      // File file = File(result.files.single.path!);
      PlatformFile file = result.files.first;
      String fileName = file.name;
      Uint8List? fileBytes;

      print("File Name: $fileName");

      if (kIsWeb) {
        fileBytes = file.bytes;
      } else {
        File selectedFile = File(file.path!);
        fileBytes = await selectedFile.readAsBytes();
      }

      if (fileBytes != null) {
        // handleFileUpload(fileBytes, fileName);
        setState(() {
          documentDataToSend.add(fileBytes!);
          documentLinksToSend.add(fileName);
        });
      }
    }
  }

  String getFileNameFromUrl(String url) {
    // Parse the URL using the Uri class
    Uri uri = Uri.parse(url);

    // Get the last segment of the path, which represents the filename
    String fileName = uri.pathSegments.last;

    // If the filename contains query parameters, remove them
    if (fileName.contains('?')) {
      fileName = fileName.substring(0, fileName.indexOf('?'));
    }

    fileName = path.basename(fileName);

    // Return the shortened filename
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 18, 32),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 30, 48),
        title: const Text(
          'Aulas',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Card(
                color: const Color.fromARGB(255, 13, 30, 48),
                // color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.703,
                          height: (MediaQuery.of(context).size.width * 9.0 / 16.0) * 0.65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Video(
                              height: (MediaQuery.of(context).size.width * 9.0 / 16.0) * 0.7,
                              width: MediaQuery.of(context).size.width * 0.703,
                              controller: controller,
                              filterQuality: FilterQuality.high, // video quality
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: 
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            // child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(                          
                                    color: Color.fromARGB(255, 27, 52, 79),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                              playlist.length > 0 ? playlist[selectedVideoIndex].name : "",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400, // or 500
                                                  color: Colors.white, // Set the text color to white
                                                ),  
                                              ), 
                                              // FutureBuilder<String>(
                                              //   future: getVideoFileName(selectedVideoIndex),
                                              //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                              //     if (snapshot.connectionState == ConnectionState.waiting) {
                                              //       return CircularProgressIndicator();
                                              //     } else if (snapshot.hasError) {
                                              //       return Text('Error: ${snapshot.error}');
                                              //     } else {
                                              //       String videoFileName = snapshot.data!;
                                              //       return Text(
                                              //         videoFileName,
                                              //         style: TextStyle(
                                              //             fontSize: 24,
                                              //             fontWeight: FontWeight.w400, // or 500
                                              //             color: Colors.white, // Set the text color to white
                                              //           ),                                             
                                              //       );
                                              //     }
                                              //   }),
                                              SizedBox(height: 30),
                                              Visibility(
                                                visible: documents.length > 0,
                                                child: Text(
                                                  'Documentos',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: documents.length > 0,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                  shrinkWrap: true,
                                                  itemCount: documents.length,
                                                  itemBuilder: (context, index) {
                                                    String link = documents[index];
                                                    String name = getFileNameFromUrl(link);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        // Handle redirection to another tab
                                                        // Redirect to another tab with the link 
                                                        // _launchURL(link);  
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 3),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: name,
                                                            style: TextStyle(color: Colors.blue),
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {launchUrl(Uri.parse(link));}
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                }),
                                              ),
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 8.0),
                                              child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Visibility(
                                                      // visible: documentLinksToSend.length > 0,
                                                      visible: mentor,
                                                      child: Text(
                                                        'Adicionar Documentos',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Visibility(
                                                      visible: mentor,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            selectFile();
                                                          },
                                                          // child: Text('Esolher Documento'),
                                                          child: Icon(Icons.upload),
                                                        ),
                                                      ),
                                                    ),                                                    
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                ListView.builder(
                                                  padding: EdgeInsets.symmetric(vertical: 5),
                                                  shrinkWrap: true,
                                                  itemCount: documentLinksToSend.length,
                                                  itemBuilder: (context, index) {
                                                    String link = documentLinksToSend[index];
                                                    return Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // Handle redirection to another tab
                                                            // Redirect to another tab with the link  
                                                            // 
                                                          },
                                                          child: Text(
                                                          link,
                                                          style: TextStyle(color: Colors.blue),
                                                                                                              ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              documentLinksToSend.removeAt(index);
                                                            });
                                                          },
                                                          child: Icon(
                                                            size: 20,
                                                            Icons.close,
                                                            color: Colors.white,
                                                          )
                                                        )
                                                      ]
                                                    );
                                                  },
                                                ),
                                                Visibility(
                                                  visible: mentor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Visibility(
                                                      visible: documentLinksToSend.length > 0,
                                                      child: 
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            // selectFile();
                                                            // send group of documents to firebase
                                                            handleFileGrupUpload();
                                                          },
                                                          child: Text('Enviar Documentos'),
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            // ),
                          ),
                        // ),
                      ],
                  ),)
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, top: 27),
              child: Card(
                color: Color.fromARGB(255, 13, 30, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(        
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                      
                                // ),
                                // width: MediaQuery.of(context).size.width,
                                // padding: EdgeInsets.all(8.0),
                                // color: Colors.red, // Set the background color to red
                                child: Text(
                                  widget.playlistName, // Display the playlist name
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400, // or 500
                                    color: Colors.white, // Set the text color to white
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: mentor,
                              child: Expanded(
                                flex: 0,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        popupUploadVideos(context);
                                      },
                                      icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color.fromARGB(255, 58, 74, 88),
                        height: 0.1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: playlist.length,
                            itemBuilder: (context, index) {
                              final media = playlist[index];
                              return Column(
                                children: [
                                  ListTile(
                                    minVerticalPadding: 20,
                                    hoverColor: Color.fromARGB(255, 10, 24, 40),
                                    title: Row(
                                      children: [
                                        Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: index == selectedVideoIndex ? Color.fromARGB(255, 74, 132, 180) : Colors.white,
                                            fontWeight: FontWeight.w300
                                          ),                                         
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            playlist.length > 0 ? playlist[index].name : "",
                                            style: TextStyle(
                                              color: index == selectedVideoIndex ? Color.fromARGB(255, 74, 132, 180) : Colors.white,
                                              fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      playVideoAtIndex(index);
                                      getDocumentsFromServer();
                                    },
                                    selected: index == selectedVideoIndex,
                                  ),
                                  Divider(
                                    color: Color.fromARGB(255, 58, 74, 88),
                                    height: 0.1,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadVideos extends StatefulWidget {
  final String playlist;
  final newVideoIndex;

  const UploadVideos({Key? key, required this.playlist, required this.newVideoIndex}) : super(key: key);

  @override
  State<UploadVideos> createState() => _UploadVideosState();
}

class _UploadVideosState extends State<UploadVideos> {
  List<Uint8List> videoBytesList = [];
  List<String> videoFileNames = [];
  bool isUploading = false;
  bool uploadFailed = false;

  Future<void> handleVideoUpload() async {
    print("VIDEO NAMES: $videoFileNames");
    print("VIDEO BYTES: ${videoBytesList.length}");

    if (videoBytesList.isNotEmpty && videoFileNames.isNotEmpty) {
      setState(() {
        isUploading = true;
        uploadFailed = false;
      });
      // Perform your video upload logic for each video in the list
      for (int i = 0; i < videoBytesList.length; i++) {
        Uint8List videoBytes = videoBytesList[i];
        String videoFileName = videoFileNames[i];

        try {
         await handleFileUpload(videoBytes, videoFileName);
        } catch (e) {
          setState(() {
            uploadFailed = true;
          });
          print('Error uploading video: $e');
        }
      }

      print("PENIS MUIT GROSSO");
      // Clear the selected videos after upload

      print("VIDEO NAMES: $videoFileNames");
    }
  }

  Future<void> handleFileUpload(Uint8List fileBytes, String fileName) async {
    // Upload the file to Firebase or any other storage
    // Retrieve the video link after successful upload
    String videoLink = 'https://example.com/video.mp4';
    final FirebaseStorage storage = FirebaseStorage.instance;

    // Perform the necessary upload logic here, e.g., using Firebase Storage
    String folderName = widget.playlist; // Specify the folder name in Firebase Storage
    String filePath = '$folderName/${fileName.replaceFirst(".mp4", "")}/${path.basename(fileName)}';
    // String newFileName = fileName.replaceAll(RegExp(r'\.mp4$', caseSensitive: false), '');
    // String filePath = '$folderName/$newFileName/${path.basename(fileName)}';
    Reference storageRef = storage.ref().child(filePath);

    try {
      UploadTask uploadTask = storageRef.putData(fileBytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      // setState(() {
      //   isUploading = false;
      // });

      // Handle the uploaded file download URL as needed
      print('Uploaded file download URL: $downloadURL');
    } catch (e) {
      print('Error uploading file: $e');
      // Handle the error
    }

    setState(() {
      isUploading = false;
    });

    // Print the video link
    print('Uploaded video link: $videoLink');

    setState(() {
      isUploading = false;
      videoBytesList.clear();
      videoFileNames.clear();
    });
    print("IS UPLOADING: $isUploading");
    // setState(() {
    //   videoFileNames.add(fileName);
    //   videoBytesList.add(file);
    // });
  }

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      for (var file in result.files) {
        String fileName = file.name;
        Uint8List? fileBytes;

        if (kIsWeb) {
          fileBytes = file.bytes;
        } else {
          File selectedFile = File(file.path!);
          fileBytes = await selectedFile.readAsBytes();
        }

        if (fileBytes != null) {
          setState(() {
            videoBytesList.add(fileBytes!);
            videoFileNames.add(fileName);
          });
          // print("HEREEE");
          // handleFileUpload(fileBytes, fileName);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
        // decoration: BoxDecoration(color: const Color.fromARGB(255, 13, 30, 48),),
        // child: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adicionar Aulas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Selecionar Videos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,    
                          fontWeight: FontWeight.w300   
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: selectFiles,
                        child: Icon(
                          Icons.upload
                          ),
                      ),              
                    ],
                  ),
                  if (videoFileNames.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: videoFileNames.length,
                            itemBuilder: (context, index) {
                              String fileName = videoFileNames[index];
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // maybe not add gesture detector
                                    },
                                    child: Flexible(
                                      child: Text(
                                        fileName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,    
                                          fontWeight: FontWeight.w300   
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        videoFileNames.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      size: 20,
                                      Icons.close,
                                      color: Colors.white,
                                    )
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
              TextButton(
                onPressed: () {
                  handleVideoUpload();
                  if (isUploading == false) {
                    Navigator.of(context).pop();
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    color: Colors.red.shade600,
                    constraints: BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        isUploading == false ?
                          Text(
                            'Adicionar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ) : CircularProgressIndicator(),
                      ],
                    )
                  )
                )
              ),
              if (uploadFailed)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Erro ao enviar arquivos",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                )
          ],
        );
    // );
  }
}

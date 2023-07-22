import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/providerPlayVideos.dart';
// import '../../videosFirebase/playVideo.dart';
import '../../videosFirebase/videoPlayer.dart';

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

Widget HomeItemBuilder(BuildContext context, String image, String subject) {
  ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();
  _Provider.set_get_subject(subject);

  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  const double telaTocaDeLayout = 1150.0;
  return Material(
    borderRadius: BorderRadius.circular(20.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) =>  ViewWatchVideo())
          // MaterialPageRoute(builder: (context) =>  VideosFirebase())
          // MaterialPageRoute(builder: (context) =>  VideoPlayerWidget())
          MaterialPageRoute(builder: (context) =>  MyScreen(playlistName: subject))
        );
      }, // Handle your callback.
      splashColor: Colors.green,
      child: Ink(
        height: height < telaTocaDeLayout ? 300 : 315,
        width: width < telaTocaDeLayout ? 210 : 225,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}

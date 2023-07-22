import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/watchVideo/views/watchVideoBody.dart';
import 'package:plataforma_deploy/features/watchVideo/youtube_model/youtube_Model.dart';
import 'package:provider/provider.dart';
import '../../providers/providerPlayVideos.dart';
import 'choose_subject/header.dart';

class ViewWatchVideo extends StatelessWidget {
  const ViewWatchVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();
    Future<YoutubeModel> video_playing = _Provider.set_video_playing();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<YoutubeModel>(
            future: video_playing,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      width: _screenWidth,
                      height: 80,
                      child: Header(),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 12, 23, 42),
                      width: _screenWidth,
                      height: _screenHeight-80,
                      child: WatchVideoBody(video_playing: snapshot.data!,),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

      //WatchVideoBody(video_playing: null,),
    );
  }
}
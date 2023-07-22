import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/watchVideo/views/videoPlayer.dart';
import 'package:provider/provider.dart';
import '../../../providers/providerPlayVideos.dart';
import '../youtube_model/youtube_Model.dart';
import 'footerVideoInformation.dart';
import 'listViewBuilder.dart';

class WatchVideoBody extends StatefulWidget {
  final YoutubeModel video_playing;
  const WatchVideoBody({Key? key, required this.video_playing,}) : super(key: key);

  @override
  State<WatchVideoBody> createState() => _WatchVideoBodyState();
}

class _WatchVideoBodyState extends State<WatchVideoBody> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();

    return Container(
      color: Color.fromARGB(255, 12, 23, 42),
        child:
        _screenWidth > 1272
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 22,),
                    /*FutureBuilder<YoutubeModel>(
                      future: video_playing,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: (_screenWidth * 964 / 1440) - 10,
                            height: _screenWidth < 1074
                                ? 400
                                : 400 + ((_screenWidth - 1074) * 0.4),
                            child: YoutubePlayer(video: snapshot.data!,),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),*/
                    SizedBox(
                      width: (_screenWidth * 964 / 1440) - 10,
                      height: _screenWidth < 1074
                          ? 400
                          : 400 + ((_screenWidth - 1074) * 0.4),

                      child: YoutubePlayer(video: widget.video_playing,),
                    ),

                    FooterVideoInformation(channelName: widget.video_playing.authorName, channelPicture: '', videoName:  widget.video_playing.title,),
                    //InfoAboutVideo(),
                  ],
                ),
              ),
            const Playlist_view(),
        ],
      )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  /*Padding(
                    padding: EdgeInsets.only(
                        left: _screenWidth / 1440 * 24,
                        right: _screenWidth / 1440 * 24,
                        top: 24,
                        bottom: 16),
                    child: FutureBuilder<YoutubeModel>(
                      future: video_playing,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: (_screenWidth * 964 / 1440) - 10,
                            height: _screenWidth < 1074
                                ? 400
                                : 400 + ((_screenWidth - 1074) * 0.4),
                            child: YoutubePlayer(video: snapshot.data!),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),*/
                  SizedBox(
                    width: (_screenWidth * 964 / 1440) - 10,
                    height: _screenWidth < 1074
                        ? 400
                        : 400 + ((_screenWidth - 1074) * 0.4),
                    child: YoutubePlayer(video: widget.video_playing,),
                    ),
                  FooterVideoInformation(channelName: widget.video_playing.authorName, channelPicture: '', videoName:  widget.video_playing.title,),

                  //const FooterVideoInformation(),
                  //const InfoAboutVideo(),
                ],
              ),
            ),
            const Playlist_view(),
      ],)
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:plataforma_conquistando_mundo/features/watchVideo/views/videoPlayer.dart';
import 'package:provider/provider.dart';
import '../../../providers/providerPlayVideos.dart';
import '../youtube_model/youtube_Model.dart';
import 'footerVideoInformation.dart';
import 'listViewBuilder.dart';

class WatchVideoBody extends StatefulWidget {
  const WatchVideoBody({Key? key,}) : super(key: key);

  @override
  State<WatchVideoBody> createState() => _WatchVideoBodyState();
}

class _WatchVideoBodyState extends State<WatchVideoBody> {

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();
    Future<String>? video_playing = widget.video_playing;
    Future<YoutubeModel> video = _Provider.get_video_data_by_id();

    return _screenWidth > 1272
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 22,),
                    FutureBuilder<String>(
                      future: video_playing,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: (_screenWidth * 964 / 1440) - 10,
                            height: _screenWidth < 1074
                                ? 400
                                : 400 + ((_screenWidth - 1074) * 0.4),
                            child: Youtube Player(video_id: snapshot.data!),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    FooterVideoInformation(channelName: 'video.authorName', channelPicture: '', videoName: 'video.providerName',),
                    //InfoAboutVideo(),
                  ],
                ),
              ),
          MyListView(),
        ],
      )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: _screenWidth / 1440 * 24,
                        right: _screenWidth / 1440 * 24,
                        top: 24,
                        bottom: 16),
                    child: FutureBuilder<String>(
                      future: video_playing,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: (_screenWidth * 964 / 1440) - 10,
                            height: _screenWidth < 1074
                                ? 400
                                : 400 + ((_screenWidth - 1074) * 0.4),
                            child: YoutubePlayer(video_id: snapshot.data!),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  FooterVideoInformation(channelName: 'video.authorName', channelPicture: '', videoName:' video.providerName',),

                  //const FooterVideoInformation(),
                  //const InfoAboutVideo(),
                ],
              ),
            ),
          const MyListView(),
      ],
    );
  }
}
*/

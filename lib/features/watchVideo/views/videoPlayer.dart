import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/providerPlayVideos.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../youtube_model/youtube_Model.dart';
import 'footerVideoInformation.dart';
import 'listViewBuilder.dart';

class YoutubePlayer extends StatefulWidget {
  final YoutubeModel video;
  YoutubePlayer( {Key? key, required this.video}) : super(key: key);

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {

  late YoutubePlayerController _controller;

  double playerWidth = 400;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.video.video_id,
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();
    //String video_title = _Provider.getVideoChannelName(_controller.params.playlist.first);
    //print("video_title: $video_title");
    const player = YoutubePlayerIFrame();

    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,

      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: (_screenWidth * 964 / 1440) - 10,
                    height: _screenWidth < 1074
                        ? 400
                        : 400 + ((_screenWidth - 1074) * 0.4),

                    child: player,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}


import 'package:flutter/material.dart';
import 'package:plataforma_deploy/features/watchVideo/views/playlistWidget.dart';
import 'package:plataforma_deploy/features/watchVideo/views/watchVideoBody.dart';
import 'package:provider/provider.dart';
import '../../../getDataPlayList.dart';
import '../../../providers/providerPlayVideos.dart';
import '../youtube_model/youtube_Model.dart';

class Playlist_view extends StatefulWidget {

  const Playlist_view({super.key});

  @override
  _Playlist_viewState createState() => _Playlist_viewState();
}
class _Playlist_viewState extends State<Playlist_view> {
  DaoYoutube daoYoutube = DaoYoutube();
  @override
  Widget build(BuildContext ctxt) {

    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    ProviderPlayVideos _Provider = context.watch<ProviderPlayVideos>();
    Future<List<YoutubeModel>> videos = _Provider.getAllVideos();

    return Material(
      color: const Color.fromARGB(255, 12, 23, 42),
      child: SizedBox(
          width: ((_screenWidth/1440)*404)-10,
          height: _screenHeight,

          child: FutureBuilder<List<YoutubeModel>>(
            future: videos,
            builder: (BuildContext context, AsyncSnapshot<List<YoutubeModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    YoutubeModel video = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.only(left: _screenWidth/1440*2 ,right: _screenWidth/1440*24,top:22 ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WatchVideoBody(video_playing: video),)
                          );
                        },
                        child: PlaylistWidget(
                          imageUrl: video.thumbnailURL,
                          textVideo: video.title,
                          nameProfessor: video.authorName,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
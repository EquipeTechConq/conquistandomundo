import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plataforma_deploy/snippet.dart';

class DaoYoutube {

  static var client = http.Client();

  Future fetchVideos({required String playListId}) async {
    String url = 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails&maxResults=3&playlistId=$playListId&key=AIzaSyDw3Yg7UHrizuvmb_jXOaIvhJuWifcDUmg';
    var response = await client.get(Uri.parse(url));

    if(response.statusCode == 200) {
      Map<dynamic, dynamic> map = json.decode(response.body);
      return map;
    } else {
      return null;
    }
  }

  Future<List<Snippet>> snippetsFromJsom({required String playListId}) async{
    Map<dynamic, dynamic> map = await fetchVideos(playListId: playListId);
    List<Snippet> listSipped = [];

    for(int i = 0; i<map['items'].length; i++){
      String videoId = map['items'][0]['contentDetails']['videoId'];
      String thumbnailImage = map['items'][0]['snippet']['thumbnails']['default']['url'];
      String videoTitle = map['items'][0]['snippet']['title'];
      String videoDate = map['items'][0]['snippet']['publishedAt'];
      String videoChannelName = map['items'][0]['snippet']['videoOwnerChannelTitle'];

      listSipped.add(Snippet(
          videoId: videoId,
          thumbnailImage: thumbnailImage,
          videoTitle: videoTitle,
          videoDate: videoDate,
          videoChannelName: videoChannelName
      ));
    }

    return listSipped;
  }
}
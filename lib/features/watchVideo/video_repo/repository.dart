import 'package:http/http.dart' as http;

class VideoRepository {
  static Future<http.Response> getVideoInfo(String id) {
    return http.get(Uri.parse(
        'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$id&format=json'));
  }
}
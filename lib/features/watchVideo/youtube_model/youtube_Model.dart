class YoutubeModel {
  String title = "";
  String authorName = "";
  String authorURL = "";
  String type = "";
  int height = 0;
  int width = 0;
  String version = "";
  String providerName = "";
  String providerURL = "";
  int thumbnailHeight = 30;
  int thumbnailWidth = 30;
  String thumbnailURL = "";
  String html = "";
  String video_id = "";

  YoutubeModel({
        required this.title,
        required this.authorName,
        required this.authorURL,
        required this.type,
        required this.height,
        required this.width,
        required this.version,
        required this.providerName,
        required this.providerURL,
        required this.thumbnailHeight,
        required this.thumbnailWidth,
        required this.thumbnailURL,
        required this.html,
        required this.video_id,
  });

  YoutubeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authorName = json['author_name'];
    authorURL = json['author_url'];
    type = json['type'];
    height = json['height'];
    width = json['width'];
    version = json['version'];
    providerName = json['provider_name'];
    providerURL = json['provider_url'];
    thumbnailHeight = json['thumbnail_height'];
    thumbnailWidth = json['thumbnail_width'];
    thumbnailURL = json['thumbnail_url'];
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['author_name'] = authorName;
    data['author_url'] = authorURL;
    data['type'] = type;
    data['height'] = height;
    data['width'] = width;
    data['version'] = version;
    data['provider_name'] = providerName;
    data['provider_url'] = providerURL;
    data['thumbnail_height'] = thumbnailHeight;
    data['thumbnail_width'] = thumbnailWidth;
    data['thumbnail_url'] = thumbnailURL;
    data['html'] = html;
    return data;
  }
}

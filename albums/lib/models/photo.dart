class Photo {
  int id;
  int albumId;
  String title;
  String thumbnailUrl;

  Photo.fromJson(Map<String, dynamic> json)
  : title = json['title'],
    albumId = json['albumId'],
    thumbnailUrl = json['thumbnailUrl'],
    id = json['id'];

}
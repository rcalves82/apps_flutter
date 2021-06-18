import 'dart:convert';
import 'package:albums/models/item.dart';
import 'package:albums/models/photo.dart';
import 'package:http/http.dart' as http;

class AlbumapiService{
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Item>> getAlbum() async {
      var response = await http.get('$baseUrl/users/1/albums');
      if(response.statusCode == 200){
        var data = jsonDecode(response.body) as List;
        List<Item> lista = [];
        data.forEach((element) {
          var it = Item.fromJson(element);
          lista.add(it);
        });
        return lista;
      } else {
        return [];
      }
  }

  Future<List<Photo>> getPhoto(int albumId) async {
    var response = await http.get('$baseUrl/albums/$albumId/photos');
    if(response.statusCode == 200) {
      var objs = jsonDecode(response.body) as List;
      var photo = objs.map((obj) => Photo.fromJson(obj)).toList();
      return photo;
    } else {
      return null;
    }
  }

}
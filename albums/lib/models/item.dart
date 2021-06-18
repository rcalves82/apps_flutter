class Item{
  String title;
  int id;
  int userId;

  Item.fromJson(Map<String, dynamic> json)
    :
      userId = json['userId'],
      id = json['id'],
      title = json['title'];

}
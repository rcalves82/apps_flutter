import 'package:albums/models/item.dart';
import 'package:albums/screens/photo_detail.dart';
import 'package:albums/services/albumapi_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _albumapiService = AlbumapiService();

  @override
  void initState() {
    super.initState();
    /*_albumapiService.getAlbum().then((value){
      print(value);
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Álbuns', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white38,
      ),
      body: FutureBuilder<List<Item>>(
        future: _albumapiService.getAlbum(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhotoDetail(snapshot.data[index].id)
                          )
                      );
                    },
                    child: Card(
                      child: ListTile(
                        // leading: Image.network('https://via.placeholder.com/150/92c952'),
                        title: Text('${snapshot.data[index].title}'),
                        // subtitle: Text('id: ${snapshot.data[index].id}'),
                      ),
                    ),
                  );
                },
            );
          } else if(snapshot.hasError){
            return Text('erro');
          } else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}

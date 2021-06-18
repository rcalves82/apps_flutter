import 'package:albums/models/photo.dart';
import 'package:albums/services/albumapi_service.dart';
import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  final _albumapiService  = AlbumapiService();
  final int photo;

 PhotoDetail(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white38,
      ),
      body: Container(
        child: FutureBuilder<List<Photo>>(
          future: _albumapiService.getPhoto(photo),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Image.network('${snapshot.data[index].thumbnailUrl}', height: 80,),
                              subtitle: Text('${snapshot.data[index].title}'),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            } else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}


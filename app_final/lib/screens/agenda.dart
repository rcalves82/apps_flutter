import 'dart:convert';
import 'package:app_final/models/Servico.dart';
import 'package:app_final/screens/agendar_servico.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  List<CamposServicos> client = [];
  final _doneStyle = TextStyle(color: Colors.green, decoration: TextDecoration.lineThrough);

  @override
  void initState() {
    super.initState();
    _carregarList();

  }

  _carregarList() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    var data = prefes.getString('client');
    if(data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        client = objs.map((obj) => CamposServicos.fromJson(obj)).toList();
      });

    }
  }

  _removeService(int index){
    setState(() {
      client.removeAt(index);
    });
    SharedPreferences.getInstance().then((prefes) =>
        prefes.setString('client', jsonEncode(client)));
  }

  _doneService(int index){
      setState(() {
        client[index].status = 'D';
      });
      SharedPreferences.getInstance().then((prefes) =>
          prefes.setString('client', jsonEncode(client)));
  }

  _showAlertDialog(BuildContext context, String conteudo, Function confirm, int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Confirmação'),
            content: Text(conteudo),
            actions: [
              FlatButton(
                  child: Text('Não'),
                  onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  confirm(index);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Agenda de serviços'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: client.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${client[index].hora} - ${client[index].dia} - ${client[index].servico}',
                          style: client[index].status == 'D' ? _doneStyle : null),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Servicos(servico: client[index], index: index),
                  )
              ).then((value) => _carregarList()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.red,
                      onPressed: () => _showAlertDialog(context, 'Confirma a exclusão do serviço?', _removeService, index)
                  ),
                  Visibility(
                      visible: client[index].status == 'O',
                      child: IconButton(
                        icon: Icon(Icons.check),
                        color: Colors.green,
                        onPressed: () => _showAlertDialog(context, 'Confirma a finalização do serviço?', _doneService, index)
                      )
                  ),
                ],
              ),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Servicos(servico: null, index: -1),
            )).then((value) => _carregarList()),
      ),
    );
  }
}


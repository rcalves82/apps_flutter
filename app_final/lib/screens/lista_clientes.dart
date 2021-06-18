import 'dart:convert';
import 'package:app_final/models/Cadastro.dart';
import 'package:app_final/screens/cadastrar_cliente.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  List<CadastroCliente> list = [];

  // Metodo é executado na inicialização do app
  @override
  void initState() {
    super.initState();
    _reloadList();
  }

  //Metodo que grava e carrega dados de outra tela
  _reloadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('list');
    if(data != null){
      setState(() {
        var objs = jsonDecode(data) as List;
        list = objs.map((obj) => CadastroCliente.fromJson(obj)).toList();
      });

    }
  }

  _removeClient(int index){
    setState(() {
      list.removeAt(index);
    });

    SharedPreferences.getInstance().then((prefs) => prefs.setString('list', jsonEncode(list)));

  }

  _mostrarAlert(BuildContext context, String conteudo,
      Function confirmFunction, int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Confirmação'),
            content: Text(conteudo),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Não')),
              FlatButton(
                  onPressed: () {
                    confirmFunction(index);
                    Navigator.pop(context);
                  },
                  child: Text('Sim')),
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
        title: Text('Lista de Clientes'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${list[index].nome}'),
              subtitle: Text('${list[index].phone}'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cadastro(cliente: list[index], index: index,)
                  )).then((value) => _reloadList()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => _mostrarAlert(context, 'Confirma a excludão desse cliente?',
                            _removeClient, index),

                    )
                  ],
                ),
            );
          },
      ),
    );
  }
}

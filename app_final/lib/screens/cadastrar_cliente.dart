import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_final/models/Cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  //Criando um construtor
  final CadastroCliente cliente;
  final int index;
  Cadastro({Key key, @required this.cliente, @required this.index}) : super(key : key);

  @override
  _CadastroState createState() => _CadastroState(cliente, index);
}

class _CadastroState extends State<Cadastro> {
  CadastroCliente _cliente;
  int _index;

  final _nomeController = TextEditingController();
  final _phoneController = TextEditingController();

  final key = GlobalKey<ScaffoldState>();

  _CadastroState(CadastroCliente cliente, int index){
    this._cliente = cliente;
    this._index = index;

    if(_cliente != null){
      _nomeController.text = _cliente.nome;
      _phoneController.text = _cliente.phone;
    }

  }

  _saveClint() async {
      //Condição para verificar se os campos estão preenchidos
      if(_nomeController.text.isEmpty || _phoneController.text.isEmpty){
        key.currentState.showSnackBar(SnackBar(
            content: Text('Nome e Telfone são obrigatórios')
        ));
      } else {

        // Importar o SharedPreferences no arquivo pubspec.yaml
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<CadastroCliente> list = [];
        var data = prefs.getString('list');
        //Testar se o prefs funciona
        /*prefs.setString('chave', 'teste de valor');
        debugPrint(prefs.getString('chave'));*/
        if(data != null){
          var objs = jsonDecode(data) as List;
          list = objs.map((obj) => CadastroCliente.fromJson(obj)).toList();
        }

        _cliente = CadastroCliente.fromNomeTelefone(
            _nomeController.text, _phoneController.text);
        // para editar o cadastro
        if(_index != -1 ){
          list[_index] = _cliente;
        } else {
          list.add(_cliente);
        }
        prefs.setString('list', jsonEncode(list));

        //Aqui para não editar
        /*list.add(_cliente);
      prefs.setString('list', jsonEncode(list));*/

        //Salva e sai da tela de cadastro
        Navigator.pop(context);

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('IGTI CarWashing'),
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text("Cadastro de Clientes", style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
                fontWeight: FontWeight.bold
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                hintText: 'Nome',
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  hintText: 'Telefone',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: double.maxFinite,
                child: RaisedButton(
                  child: Text('Salvar', style: TextStyle(fontSize: 20.0),),
                  color: Colors.black54,
                  textColor: Colors.white,
                  onPressed: () => _saveClint()
                ),
              ),
            ),
        ],
      )
    );
  }
}
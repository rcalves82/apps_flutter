import 'dart:convert';
import 'package:app_final/models/Servico.dart';
// import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';


class Servicos extends StatefulWidget {
  final CamposServicos servico;
  final int index;
  Servicos({Key key, @required this.servico, @required this.index}) : super(key:key);

  @override
  _ServicosState createState() => _ServicosState(servico, index);
}

class _ServicosState extends State<Servicos> {
  CamposServicos _servico;
  int _index;

  final _clienteController = TextEditingController();
  final _dataController = TextEditingController();
  final _horasController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  // DateTime _data = DateTime.now();

  //variavel que recebe as informações do RadioList
  String _optEscolhida;

  _ServicosState(CamposServicos servico, int index){
    this._servico = servico;
    this._index = index;
    if(_servico != null){
      _horasController.text = _servico.hora;
      //aqui converter DateTime pra String
      _dataController.text = _servico.dia;
      _optEscolhida = _servico.servico;
      _clienteController.text = _servico.cliente;
    }
  }

  _saveAgendamento() async {

    if(_clienteController.text.isEmpty || _dataController.text.isEmpty
        || _horasController.text.isEmpty || _servico.toString().isEmpty){
      key.currentState.showSnackBar(SnackBar(
          content: Text('Todos os campos são obrigatorios')
      ));
    } else {
      //SharedPreferences salva dados na memoria do dispositivo
      SharedPreferences prefes = await SharedPreferences.getInstance();
      List<CamposServicos> client = [];

      var data = prefes.getString('client');
      if(data != null) {
        var objs = jsonDecode(data) as List;
        client = objs.map((obj) => CamposServicos.fromJson(obj)).toList();
      }

      _servico = CamposServicos.fromServicos(
          _horasController.text, _dataController.text, _optEscolhida.toString(), _clienteController.text);
      if(_index != -1){
        client[_index] = _servico;
      } else {
        client.add(_servico);
      }
      prefes.setString('client', jsonEncode(client));
      //retorna a tela anterior
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
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Agendar Serviços", style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _clienteController,
              decoration: InputDecoration(
                  hintText: 'Digite o nome do Cliente',
                  border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Escolha a data do serviço', style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
                fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _dataController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: IconButton(
                    icon: Icon(Icons.date_range, color: Colors.black45,),
                    onPressed: () async{
                      final _dateTime = await showDatePicker(
                          context: context,
                          initialDate: _data,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                      );
                      setState(() {
                        String dataformato;
                        Text (dataformato = DateFormat('dd/MM/yyyy').format(_dateTime));
                      });

                    },
                  )

                ),

              ),
          ),*/
          /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black54
                ),
                child: Column(
                  children: [
                    Text('${formatDate(_data, [dd, '/', mm, '/', yyyy])}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onPressed: () async{
                  final dtPicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  if(dtPicker != null && dtPicker != _data){
                    setState(() {
                      _data = dtPicker;
                    });
                  }
                },
              ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _dataController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Informe a data do atendimento',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Escolha o horario do serviço', style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _horasController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  hintText: 'Informe o horário do atendimento',
                  border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('Lavagem Simples', style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    subtitle: Text('Valor R\$50,00 reais', style: TextStyle(fontWeight: FontWeight.bold),),
                    activeColor: Colors.black26,
                    value: 'Lavagem Simples',
                    groupValue: _optEscolhida,
                    onChanged: (String valor) {
                      setState(() {
                        _optEscolhida = valor;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Lavagem Completa s/Cera', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Valor R\$100,00 reais', style: TextStyle(fontWeight: FontWeight.bold),),
                    activeColor: Colors.black54,
                    value: 'Lavagem Completa s/Cera',
                    groupValue: _optEscolhida,
                    onChanged: (String valor) {
                      setState(() {
                        _optEscolhida = valor;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Lavagem Completa c/Cera', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Valor R\$150,00 reais', style: TextStyle(fontWeight: FontWeight.bold),),
                    activeColor: Colors.black,
                    value: 'Lavagem Completa c/Cera',
                    groupValue: _optEscolhida,
                    onChanged: (String valor) {
                      setState(() {
                        _optEscolhida = valor;
                      });
                    },
                  ),
                ],
              ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                child: Text('Agendar', style: TextStyle(fontSize: 20),),
                color: Colors.black54,
                textColor: Colors.white,
                onPressed: () => _saveAgendamento(),
            ),
          )
        ],
      ),
    );
  }
}


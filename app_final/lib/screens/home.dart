import 'package:app_final/screens/agenda.dart';
import 'package:app_final/screens/agendar_servico.dart';
import 'package:app_final/screens/cadastrar_cliente.dart';
import 'package:app_final/screens/lista_clientes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('IGTI CarWashing'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  child: Text('Cadastro de Clientes', style: TextStyle(fontSize: 30.0),),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.black45,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cadastro(cliente: null, index: -1,)
                      )
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  child: Text('Lista de Clientes', style: TextStyle(fontSize: 30),),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.black45,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Clientes())
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  child: Text('Agendar Serviço', style: TextStyle(fontSize: 30),),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.black45,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Servicos(servico: null, index: -1,))
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                  child: Text('Agenda', style: TextStyle(fontSize: 30),),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.black45,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Agenda())
                  )
              ),
            ),
          ),

        ],
      )
    );
  }
}

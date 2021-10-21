import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map();
  final _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    //criar o arquivo caminho/dados.json
    return File("${diretorio.path}/dados.json");
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    if (_controllerTarefa.text.isEmpty) {
      //showSnackbar mostra mensagem no celular
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Campos título e descrição são obrigatórios.'),
        duration: Duration(seconds: 2),
      ));
      _exibirTelaAnotacao();
    } else {
      //Criar dados
      Map<String, dynamic> tarefa = Map();
      tarefa["titulo"] = textoDigitado;
      tarefa["realizada"] = false;

      setState(() {
        _listaTarefas.add(tarefa);
      });
      _salvarArquivo();
      _controllerTarefa.clear();
    }
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();

    //Testando criar arquivo antes
    /*Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add(tarefa);*/

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);

    // print("Caminho: ${diretorio.path}");
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  Widget criarItemLista(context, index) {
    // final item = _listaTarefas[index]["titulo"];

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        //recuperar último item excluído
        _ultimaTarefaRemovida = _listaTarefas[index];

        //Remover item da lista
        _listaTarefas.removeAt(index);
        _salvarArquivo();

        //snackbar
        final snackbar = SnackBar(
            //backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                //Insere novamente item removido na lista
                setState(() {
                  _listaTarefas.insert(index, _ultimaTarefaRemovida);
                });
                _salvarArquivo();
              },
            ),
            content: Text("Tarefa removia!"));
        Scaffold.of(context).showSnackBar(snackbar);
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text(_listaTarefas[index]["titulo"]),
        value: _listaTarefas[index]["realizada"],
        onChanged: (valorAlterado) {
          setState(() {
            _listaTarefas[index]["realizada"] = valorAlterado;
          });

          _salvarArquivo();
        },
      ),
    );
  }

  _exibirTelaAnotacao(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Adicionar tarefa"),
            content: TextField(
              controller: _controllerTarefa,
              decoration:
              InputDecoration(labelText: "Digitia uma nova tarefa"),
              onChanged: (text) {},
            ),
            actions: [
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("Salvar"),
                onPressed: () {
                  _salvarTarefa();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // _salvarArquivo();
    // print("itens: " + DateTime.now().millisecondsSinceEpoch.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () {
          _exibirTelaAnotacao();
        },
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length, itemBuilder: criarItemLista))
      ]),
    );
  }
}

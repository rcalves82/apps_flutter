import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/helper/AnotacaoHelper.dart';
import 'package:minhas_anotacoes/model/Anotacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final key = GlobalKey<ScaffoldState>();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = List<Anotacao>();

  _exibirTelaCadastro({Anotacao anotacao}){

    String textoSalvarAtualizar = "";
    if(anotacao == null){
      _tituloController.text = "";
      _descricaoController.text = "";
      textoSalvarAtualizar = "Salvar";
    }else{//atualizar
      _tituloController.text = anotacao.titulo;
      _descricaoController.text = anotacao.descricao;
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('$textoSalvarAtualizar anotação'),
          content: Column(
            //define o tamanho do componente na tela
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Título",
                  hintText: "Digite título..."
                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                    labelText: "Descrição",
                    hintText: "Digite descrição..."
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar")
            ),
            FlatButton(
                onPressed: () {

                  //salvar
                  _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);

                  Navigator.pop(context);
                },
                child: Text(textoSalvarAtualizar)
            )
          ],
        );
      }
    );
  }

  _recuperarAnotacoes() async {

    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<Anotacao> listaTemporaria = List<Anotacao>();
    for ( var item in anotacoesRecuperadas){

        Anotacao anotacao = Anotacao.fromMap(item);
        listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = null;

    // print("Lista anotacoes: " + anotacoesRecuperadas.toString());

  }

  _salvarAtualizarAnotacao({Anotacao anotacaoSelecionada}) async{

    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    if(titulo.isEmpty || descricao.isEmpty){
      key.currentState.showSnackBar(SnackBar(
        content: Text('Campos título e descrição são obrigatórios.'),
        duration: Duration(milliseconds: 3),
      ));
      _exibirTelaCadastro();
      // print("data atual " + DateTime.now().toString());
    } else if(anotacaoSelecionada == null){
      Anotacao anotacao = Anotacao(titulo, descricao, DateTime.now().toString());
      int resultado = await _db.salvarAnotacao(anotacao);
    }else{//atualizar
      anotacaoSelecionada.titulo    = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data      = DateTime.now().toString();
      int resultado = await _db.atualizarAnotacao(anotacaoSelecionada);
    }
    // debugPrint("salvar anotacao: " + resultado.toString());

    //Limpar o campo apos salvar inserção
    _tituloController.clear();
    _descricaoController.clear();
    _recuperarAnotacoes();


  }

  //Metodo para formatar data
  _formatarData(String data){
    initializeDateFormatting("pt_BR");

    //Year -> y Month -> M (M maisculo representa o Mês e m minusculo minuto Day -> d
    //Hour -> H minute -> m second -> s
    // var formatador = DateFormat("d/MM/y H:m:s");
    var formatador = DateFormat.yMd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  _removerAnotacao(int id) async {
    await _db.removerAnotacao(id);

    _recuperarAnotacoes();
  }


  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Minhas anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _anotacoes.length,
                  itemBuilder: (context, index) {

                    final anotacao = _anotacoes[index];

                    return Card(
                      child: ListTile(
                        title: Text(anotacao.titulo),
                        subtitle: Text("${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                        //Ações nas laterais do APP
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(anotacao: anotacao);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green
                                ),
                              ),

                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Deseja excluir essa anotação?"),
                                        actions: [
                                          FlatButton(
                                              child: Text("Não"),
                                              onPressed: () => Navigator.pop(context),
                                          ),
                                          FlatButton(
                                            child: Text("Sim"),
                                            onPressed: () {
                                              _removerAnotacao(anotacao.id);
                                              Navigator.pop(context);
                                              },
                                          ),
                                        ],
                                      );
                                    },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red
                                ),
                              ),

                            )
                          ],
                        ),
                      ),
                    );
                  },
              )

          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          _exibirTelaCadastro();
        },
      ),
    );
  }
}

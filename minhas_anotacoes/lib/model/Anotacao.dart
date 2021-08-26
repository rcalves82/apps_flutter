class Anotacao{

  int id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  //Converter de map
  Anotacao.fromMap(Map map){
    this.id = map["id"];
    this.titulo = map["titulo"];
    this.descricao = map["descricao"];
    this.data = map["data"];

  }

  //Map que convert dados para map
  Map toMap(){
    Map<String, dynamic> map = {
      "titulo" : this.titulo,
      "descricao" : this.descricao,
      "data" : this.data,
    };

    if(this.id != null){
      map["id"] = this.id;
    }

    return map;
  }

}
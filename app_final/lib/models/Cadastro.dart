class CadastroCliente{
  String nome;
  String phone;

  CadastroCliente();

  //Construtor
  CadastroCliente.fromNomeTelefone(String nome, String phone){
    this.nome = nome;
    this.phone = phone;
  }

  //Converter para Texto
  CadastroCliente.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        phone = json['phone'];

  //Converter para objeto Json
  Map toJson() => {
      'nome' : nome,
      'phone' : phone
  };
}
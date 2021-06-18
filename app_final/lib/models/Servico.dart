import 'package:flutter/services.dart';

class CamposServicos{
  String cliente;
  String dia;
  String hora;
  String servico;
  String status;

  CamposServicos();

  CamposServicos.fromServicos(String hora, String dia, String servico, String cliente){
    this.hora = hora;
    this.dia = dia;
    this.servico = servico;
    this.cliente = cliente;
    this.status = 'O';
  }

  CamposServicos.fromJson(Map<String, dynamic> json)
    : hora = json['hora'],
      dia = json['dia'],
      servico = json['servico'],
      cliente = json['cliente'],
      status = json['status'];


  Map toJson() => {
    'hora' : hora,
    'dia' : dia,
    'servico' : servico,
    'cliente' : cliente,
    'status' : status
  };

}
import 'package:flutter/material.dart';

class Moeda extends StatefulWidget {
  @override
  _MoedaState createState() => _MoedaState();
}

class _MoedaState extends State<Moeda> {
  final TextEditingController _real = TextEditingController();
  final TextEditingController _dolar = TextEditingController();

  var _valorReal = 0.0;
  var _cotacaoDolar = 0.0;
  var _conversao = 0.0;

  _calcularCotacao() {
    _valorReal = double.parse(_real.text);
    _cotacaoDolar = double.parse(_dolar.text);
    setState(() {
      _conversao = _valorReal / _cotacaoDolar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reais para Dólar'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _real,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Valor em Reais'),
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _dolar,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: 'Cotação Dolar'),
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _calcularCotacao,
                  child: Text(
                    'Calcular',
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seu poder de compra em Reais é: ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'R\$${_conversao.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Image.asset(
              "assets/moedas_dolar.jpeg",
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}

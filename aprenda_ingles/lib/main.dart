import 'package:aprenda_ingles/telas/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    //Altera a cor padrão do tema.
    theme: ThemeData(
      //utlizando cor Hexadecimal
        primaryColor: Color(0xFFA0522D),
        // accentColor: Colors.green
        scaffoldBackgroundColor: Color(0xfff5e9b9)
    ),
  ));
}



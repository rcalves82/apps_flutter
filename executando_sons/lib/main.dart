import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "assets/audios/");
  bool primeiraExecucao = true;
  double volume = 0.5;


  _excutar() async {
    //Volume configurado
    audioPlayer.setVolume(volume);
    //Verificador para analisar se foi feita uma primeira execução
    if( primeiraExecucao ){
      //para executar audio a partir de um arquivo local
      audioPlayer = await audioCache.play("musica.mp3");
      primeiraExecucao = false;
    }else{
      audioPlayer.resume();
    }

    //para executar audio atraves de um link
    /*String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3";
    int resultado = await audioPlayer.play(url);
    if(resultado == 1){
      //sucesso
    }*/
  }

  _pausar() async{

      int resultado = await audioPlayer.pause();
      if( resultado == 1){
        //sucesso
      }
  }

  _parar() async {

    int resultado = await audioPlayer.stop();
    if( resultado == 1){
      //sucesso
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Executando sons"),),
      body: Column(
        children: [
          //Criando barra de volume
          Slider(
              value: volume,
              min: 0,
              max: 1,
              // divisions: 10,
              onChanged: (novoVolume) {
                  setState(() {
                    volume = novoVolume;
                  });
                  //
                  audioPlayer.setVolume(novoVolume);
              },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                  padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/executar.png"),
                  onTap: () {
                    _excutar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/pausar.png"),
                  onTap: () {
                    _pausar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/parar.png"),
                  onTap: () {
                    _parar();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}



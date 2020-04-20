import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';//Usar sons da internet
import 'package:audioplayers/audio_cache.dart'; //Usar sons que estão no dispositivo

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();

  //Executar sons/músicas locais
  AudioCache audioCache = AudioCache(
    prefix:  "audios/"
  );

  bool primeiraExecucao = true;

  double volume = 0.5; //Na biblioteca o volume vai de 0.0 até 1

  @override
  Widget build(BuildContext context) {
    //_executarAudio();
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
      ),
      body: Column(
        children: <Widget>[

          //Slider para fazer o controle do volume
          Slider(
            value: volume,
            min: 0,
            max: 1,
            onChanged: (novoVolume){
              setState(() {
                volume = novoVolume;
              });
              audioPlayer.setVolume(novoVolume); //Aplicar o novo volume
            }
          ),

          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[

              //Botão de executar
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/executar.png"),
                  onTap: (){
                    _executarAudio();
                  },
                ),
              ),

              //Botão de pausar
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/pausar.png"),
                  onTap: (){
                    _pausarAudio();
                  },
                ),
              ),

              //Botão de executar
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/parar.png"),
                  onTap: (){
                    _pararAudio();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _executarAudio() async{

    /* Usar audio da internet

      //Para IOS tem uma pequena exceção, quando o site é "http" que está
      // configurado em ios -> Runner -> info.plist
      String url ="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
      int resultado = await audioPlayer.play(url);

      if(resultado ==1){
      //sucesso ao carregar audio
    }

    */

    if(primeiraExecucao){
      audioPlayer = await audioCache.play("musica.mp3"); //sempre executa a música do inicio
      primeiraExecucao = false;
    }else{
       audioPlayer.resume(); //continuar a execução de onde esta parado
    }




  }

  void _pausarAudio() async {

    int resultado = await audioPlayer.pause();
    if(resultado==1){
      //sucesso
    }

  }


  void _pararAudio() async{

    int resultado = await audioPlayer.stop();
    if(resultado==1){
      //sucesso
    }


  }


}


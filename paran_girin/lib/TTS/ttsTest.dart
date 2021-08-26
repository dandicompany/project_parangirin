import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// @override
// InitializationState createState() => InitializationState();

String speaker = "ndain";
String volume = "1";
String emotion = "0";
String speed = "0";
String pitch = "1";
String format = "mp3";

String client_id = "oipjydjt49";
String client_secret = "RpmjMMy7caPJ3Hura6ALqRbxTDm5QaUcU1fPLVg8";
String url = 'https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts';

// AudioPlayer player = AudioPlayer();

AudioPlayer advancedPlayer = AudioPlayer();
AudioCache bgmplayer = AudioCache(prefix: 'assets/music/', fixedPlayer: advancedPlayer);
// AudioPlayer bgmplayer = AudioPlayer();
//text에 원하는 문구 담아서 보내면 됨.


class TextToSpeech extends StatefulWidget {
  const TextToSpeech({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  TextToSpeechState createState() => TextToSpeechState();
}

class TextToSpeechState extends State<TextToSpeech> {
  void _createPost() async {
    final response = await http.post(
      Uri.encodeFull(url),
      // url,
      body: {
        "speaker": speaker,
        "volume": volume,
        "emotion": emotion,
        "text": widget.text,
        "speed": speed,
        "pitch": pitch,
        "format": format
      },
      headers: {
        "X-NCP-APIGW-API-KEY-ID": client_id,
        "X-NCP-APIGW-API-KEY": client_secret,
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    // bgm player
    bgmplayer.play("bgm.mp3", volume: 1);

    // 아래 다 안됨
    // bgmplayer.pause();

    // bgmplayer.play("assets/music/bgm.mp3");
    // bgmplayer.setVolume(0.5); 


    // tts player
    AudioPlayer player = AudioPlayer();
    Uint8List byteData = response.bodyBytes; // Load audio as a byte array here.
    // print(byteData.length);
    String path = join((await getTemporaryDirectory()).path, 'tts.mp3');
    File file = File(path);
    file.writeAsBytesSync(byteData);
    // print(file.lengthSync());
    // await player.load(path);
    player.play(path, isLocal: true);

  }

  @override
  void initState() {
    // player = new AudioCache();
    _createPost();

  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    // bgmplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }

  
}

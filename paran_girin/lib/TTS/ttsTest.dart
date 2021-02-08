import 'package:flutter/material.dart';
import 'package:paran_girin/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';

// @override
// InitializationState createState() => InitializationState();



String speaker = "dain";
String volume = "0";
String emotion = "0";
String speed = "0";
String pitch = "0";
String format = "mp3";
String text = "안녕 호빈 친구";


String client_id = "oipjydjt49";
String client_secret = "RpmjMMy7caPJ3Hura6ALqRbxTDm5QaUcU1fPLVg8";
String url = 'https://naveropenapi.apigw.ntruss.com/voice-premium/v1/tts';


class textToSpeech extends StatefulWidget {

  @override
  textToSpeechState createState() => textToSpeechState();

}

class textToSpeechState extends State<textToSpeech> {

  void _createPost() async {
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "speaker" : speaker,
          "volume" : volume,
          "emotion" : emotion,
          "text" : text,
          "speed" : speed,
          "pitch" : pitch,
          "format" : format
        },
      ),
      headers: {"X-NCP-APIGW-API-KEY-ID": client_id ,"X-NCP-APIGW-API-KEY" : client_secret},
    );
    AudioCache player = new AudioCache();

    //asset에 있는거 접근할 때, const AudioPath = "click1.mp3"

    player.play(response.body);
  }

  @override
  void initState() {
    super.initState();
    _createPost();

  }

  @override
  Widget build(BuildContext context) {


  }
}




import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:paran_girin/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';

// @override
// InitializationState createState() => InitializationState();



String speaker = "ndain";
String volume = "10";
String emotion = "0";
String speed = "0";
String pitch = "1";
String format = "mp3";


String client_id = "oipjydjt49";
String client_secret = "RpmjMMy7caPJ3Hura6ALqRbxTDm5QaUcU1fPLVg8";
String url = 'https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts';

//text에 원하는 문구 담아서 보내면 됨.

class textToSpeech extends StatefulWidget {
  const textToSpeech({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  textToSpeechState createState() => textToSpeechState();

}



class textToSpeechState extends State<textToSpeech>  {
  void _createPost() async {
    final response = await http.post(
      url,
      body:
      {
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

    AudioCache player = new AudioCache();
    print(response);
    print("body : " + response.body);

    Uint8List byteData = response.bodyBytes; // Load audio as a byte array here.
    int result = (await player.playBytes(byteData)) as int;
  }

  @override
  void initState() {
    _createPost();
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
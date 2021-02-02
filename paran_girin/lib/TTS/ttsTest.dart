import 'package:flutter/material.dart';
import 'package:paran_girin/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  var speaker = "nara";
  var volume = "0";
  var emotion = "0";
  var speed = "0";
  var pitch = "0";
  var format = "mp3";
  var text = "안녕 호빈 친구";


  var client_id = "";
  var client_secret = "";
  var lang = "Kor";
  var url = 'https://naveropenapi.apigw.ntruss.com/voice-premium/v1/tts' + lang;

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
      headers: {"X-NCP-APIGW-API-KEY-ID": "NULL","X-NCP-APIGW-API-KEY-ID" : "NULL"},
    );
  }

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

  }
}




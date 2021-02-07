import 'package:flutter/material.dart';
import 'package:paran_girin/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}

String speaker = "nara";
String volume = "0";
String emotion = "0";
String speed = "0";
String pitch = "0";
String format = "mp3";
String text = "안녕 호빈 친구";


String client_id = "";
String client_secret = "";
String lang = "Kor";
String url = 'https://naveropenapi.apigw.ntruss.com/voice-premium/v1/tts' + lang;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
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
  }

  @override
  Widget build(BuildContext context) {

  }
}




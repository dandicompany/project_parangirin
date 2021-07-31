import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paran_girin/gallery/videoShowWidget.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/TTS/ttsTest.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/layout/splash.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

CameraDescription camera;
CameraDescription firstCamera;
CameraDescription frontCamera;
String filePath;
var cameras;
bool cameraview = true;
String question;






String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

Future<Widget> videoFunc() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  firstCamera = cameras.first;
  final frontCamera = cameras[1];

  logger.d("!!!!!!!!!!!!!!!!!!!!!!!");
  return TakePictureScreen(camera: frontCamera);
}

class Initialization extends StatefulWidget {
  String _question;
  Initialization(this._question);
  @override
  InitializationState createState() => InitializationState(_question);
}

class InitializationState extends State<Initialization> {
  String _question;
  InitializationState(this._question);
  @override
  Widget build(BuildContext context) {
    question = _question;
    return FutureBuilder(
        future: videoFunc(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            logger.d("page loaded");
            return snapshot.data;
          } else {
            return SplashScreen();
          }
        });
  }
}

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  FirebaseProvider fp;
  BuildContext context_temp;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isDisabled = false;

  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '01:30';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  var todayDate = new DateTime.now();
  bool girin_state = false;

  AudioPlayer player = new AudioPlayer();

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      int sec = 90 - swatch.elapsed.inSeconds;
      stoptimetodisplay =
          //swatch.elapsed.inHours.toString().padLeft(2, '0') +
          //":" +
          (sec ~/ 60).toString().padLeft(2, '0') +
              ":" +
              (sec % 60).toString().padLeft(2, '0').padLeft(2, '0');

      if (sec == 0) {
        if (_controller.value.isRecordingVideo) {
          stopstopwatch();
          _controller.stopVideoRecording();
          isDisabled = false;
          isDisabled = !isDisabled;
        }
        Navigator.of(context_temp)
            .push(MaterialPageRoute(builder: (context) => Outtro()));
      }
    });
  }

  void startstopwatch() {
    setState(() {
      stopispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  Widget stopwatch() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        stoptimetodisplay,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(12),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }


  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  void saveVideo() async {
    fp.addAnswer(question, filePath);
    fp.reloadUser();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    context_temp = context;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("connection done");
            logger.d(question);
            return Stack(
              children: [

                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(812),
                  //alignment: Alignment.center,
                  child: Image.asset("assets/avatars/default_background.png",
                      fit: BoxFit.cover, alignment: Alignment.bottomCenter),
                ),
                // Container(
                //   child: TextToSpeech(text: "안녕"),
                //   //", 나 뿐만 아니라 옆집 토끼아저씨, 앞집 송아지가족, 내 친구 코끼리까지. 이 외에도 정말 많아. 혹시 너도 동물이 되어보고 싶은 적 없어? 하루동안 동물이 된다면, 어떤 동물이 되고싶니?",),
                // ),
                Container(
                    child: girin_state == false
                        ? GirinSpeak(fp.getUserInfo().currentChild.nickName,
                            fp.getStaticInfo().questions[question])
                        : GirinNod()),
                Positioned(
                  top: ScreenUtil().setHeight(64),
                  right: ScreenUtil().setWidth(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: ScreenUtil().setHeight(210),
                      width: ScreenUtil().setWidth(118),
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                // ---- camera buttons
                Positioned(
                  bottom: ScreenUtil().setHeight(49),
                  // left: ScreenUtil().setWidth(152),
                  child: Column(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(79),
                        height: ScreenUtil().setHeight(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: stopwatch(),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(375),
                        height: 18,
                        // child: Text("hi"),
                      ),
                      Row(
                        children: [
                          Container(
                              width: ScreenUtil().setWidth(38),
                              height: ScreenUtil().setHeight(38),
                              color: Colors.transparent),
                          SizedBox(width: ScreenUtil().setWidth(60)),
                          _controller.value.isRecordingVideo
                              ? RawMaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_controller.value.isRecordingVideo) {
                                        stopstopwatch();
                                        _controller.stopVideoRecording();
                                        isDisabled = false;
                                        isDisabled = !isDisabled;

                                        //automatic video saving
                                        saveVideo();
                                      }
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Outtro()));
                                  },
                                  child: ImageIcon(
                                    AssetImage("assets/icons/video_Off.png"),
                                    size: ScreenUtil().setWidth(70),
                                    color: Colors.red,
                                  ),
                                  shape: CircleBorder(),
                                )
                              : RawMaterialButton(
                                  onPressed: () async {
                                    try {
                                      await _initializeControllerFuture;
                                      // 0513
                                      filePath = join(
                                          (await getApplicationDocumentsDirectory())
                                              .path,
                                          '${DateTime.now().millisecondsSinceEpoch}.mp4');
                                      logger.d(filePath);
                                      setState(() {
                                        girin_state = true;
                                        startstopwatch();
                                        _controller
                                            .startVideoRecording(filePath);
                                        isDisabled = true;
                                        isDisabled = !isDisabled;
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: ImageIcon(
                                    AssetImage("assets/icons/video_On.png"),
                                    size: ScreenUtil().setWidth(70),
                                    color: Colors.red,
                                  ),
                                  shape: CircleBorder(),
                                ),
                          SizedBox(width: ScreenUtil().setWidth(60)),
                          Container(
                              width: ScreenUtil().setWidth(38),
                              height: ScreenUtil().setHeight(38),
                              color: Colors.transparent)

                          /*
                          *                           !isDisabled
                              ? Container(
                                  width: ScreenUtil().setWidth(38),
                                  height: ScreenUtil().setHeight(38),
                                  color: Colors.transparent)
                              :  Container(
                              width: ScreenUtil().setWidth(38),
                              height: ScreenUtil().setHeight(38),
                              color: Colors.transparent)
                          ,
                          * */
                        ],
                      ),
                    ],
                  ),
                ),
                // ---- cancel button (top-left)
                Positioned(
                    top: ScreenUtil().setHeight(53),
                    left: ScreenUtil().setWidth(24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(24),
                        height: ScreenUtil().setHeight(24),
                        child: Image.asset(
                          "assets/icons/cancel.png",
                        ),
                      ),
                    )),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Outtro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 3000)),
      builder: (context, snapshot) {
        // Checks whether the future is resolved, ie the duration is over
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(812),
                  child: Image.asset("assets/avatars/default_background.png",
                  fit: BoxFit.cover, alignment: Alignment.bottomCenter),
                 ),
                Opacity( //seconds child - Opaque layer
                  opacity: 0.3,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: VideoSavePopup(),
              )
            ],
          );
        }
        else{
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(812),
                child: Image.asset("assets/avatars/default_background.png",
                    fit: BoxFit.cover, alignment: Alignment.bottomCenter),
              ),
              Align(child: TextToSpeech(text: "다음에 또 보자.")),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: ScreenUtil().setWidth(512),
                    height: ScreenUtil().setHeight(512),
                    child:
                    Image.asset("assets/avatars/speaking.gif", fit: BoxFit.cover),
                  )),
            ],
          );
        }
        });
  }
}

class GirinNod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(512),
              height: ScreenUtil().setHeight(512),
              child: Image.asset("assets/avatars/nod.gif", fit: BoxFit.cover),
            )),
      ],
    );
  }
}

class GirinHi extends StatelessWidget {
  String text = "";
  GirinHi(this.text);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: TextToSpeech(text: "안녕, ${text ?? ""} 친구?"),
        ),
        Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenUtil().setWidth(512),
              height: ScreenUtil().setHeight(512),
              child: Image.asset("assets/avatars/hi.gif", fit: BoxFit.cover),
            )),
      ],
    );
  }
}

class GirinSpeak extends StatelessWidget {
  String nick;
  Question q;
  GirinSpeak(this.nick, this.q);
  @override
  Widget build(BuildContext context) {
    logger.d(q);
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 3000)),
        builder: (context, snapshot) {
          // Checks whether the future is resolved, ie the duration is over
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: [
              Align(
                  child: TextToSpeech(
                      // text: "나 뿐만 아니라 옆집 토끼아저씨, 앞집 송아지가족, 내 친구 코끼리까지."),
                      text: q.narration1.replaceAll("안녕 __name__!", ""))),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: ScreenUtil().setWidth(512),
                    height: ScreenUtil().setHeight(512),
                    child: Image.asset("assets/avatars/speaking.gif",
                        fit: BoxFit.cover),
                  ))
            ]);
          } else {
            return GirinHi(nick);
          }
        });
  }
}

class VideoSavePopup extends StatefulWidget {
  @override
  _VideoSavePopup createState() => new _VideoSavePopup();
}

class _VideoSavePopup extends State<VideoSavePopup> {
  FirebaseProvider fp;
  int n = 2;
  @override
  Widget build(BuildContext context){
    fp = Provider.of<FirebaseProvider>(context);
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(237),
        height: ScreenUtil().setHeight(300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(28)),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: ScreenUtil().setWidth(74),
                        height: ScreenUtil().setHeight(74),
                        child: new Image.asset("assets/icons/party_popper.png", fit:BoxFit.fill),
                      )
                  ),
                  SizedBox(height: ScreenUtil().setHeight(24)),
                  Positioned(child: new Text( "우와,\n 벌써 "+ n.toString()+" 번째 만남이네요!",textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.colors.primary1, fontSize: ScreenUtil().setSp(18)), ),),
                  SizedBox(height: ScreenUtil().setHeight(26)),
                  Container(
                      width: ScreenUtil().setWidth(173),
                      height: ScreenUtil().setHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child : FlatButton(
                        child : Text( "영상 확인하기", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(16))),
                        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoShowWidget(question, fp.getStaticInfo().answers[question]))), //VideoPlayerScreen()));
                      )
                  ),
                  Container(
                      child:TextButton(
                        child: Text("나중에 확인할래요", style: TextStyle(color: AppTheme.colors.base3, fontSize: ScreenUtil().setSp(12)),),
                        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ),
                      )
                  )
                ]
            ),
          ],
        )
      ),
    );
  }
}


/*"/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4"*/
// class ChangeCameraView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: GestureDetector(
//           onTap: () {
//             if (cameraview == true) {
//               cameraview = false;
//             } else {
//               cameraview = true;
//             }
//           },
//           child: Container(
//             width: ScreenUtil().setWidth(38),
//             height: ScreenUtil().setHeight(38),
//             //padding: EdgeInsets.all(15.0),
//             child: Image.asset(
//               "assets/icons/changeCamera.png",
//             ),
//           ),
//         ));
//   }
// }


/*
*
class SaveVideo extends StatelessWidget {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Container(
        child: GestureDetector(
          onTap: () {
            saveVideo();
            Navigator.of(context).pop();
          },
          child: Container(
            width: ScreenUtil().setWidth(38),
            height: ScreenUtil().setHeight(38),
            //padding: EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/icons/saveVideo.png",
            ),
          ),
        ));
  }

  void saveVideo() async {
    fp.addAnswer(question, filePath);
    fp.reloadUser();
  }
}*/
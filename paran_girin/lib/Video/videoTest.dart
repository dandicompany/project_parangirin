import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:paran_girin/home/home_body.dart';
import 'package:paran_girin/home/home_page.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/TTS/ttsTest.dart';

CameraDescription camera;
CameraDescription firstCamera;
CameraDescription frontCamera;
String filePath;
var cameras;
String filepath;
bool cameraview = true;
bool girinchange = true;


String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

Future<void> videoFunc() async {
  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  firstCamera = cameras.first;
  final frontCamera = cameras[1];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
        camera: frontCamera,
      ),
    ),
  );
}

class Initialization extends StatefulWidget {
  @override
  InitializationState createState() => InitializationState();
}

class InitializationState extends State<Initialization> {
  @override
  Widget build(BuildContext context) {
    videoFunc();
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
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isDisabled = false;

  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  var todayDate = new DateTime.now();


  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, '0') +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
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

    // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
    _controller = CameraController(
      // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
      widget.camera,
      // 적용할 해상도를 지정합니다.
      ResolutionPreset.ultraHigh,
    );
    // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      //appBar: AppBar(title: Text('Take a Video')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(812),
                  //alignment: Alignment.center,
                  child :
                      Image.asset("assets/avatars/default_background.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter),
                ),
                Align(
                  child: TextToSpeech(text: "안녕"),
                  // 나 뿐만 아니라 옆집 토끼아저씨, 앞집 송아지가족, 내 친구 코끼리까지. 이 외에도 정말 많아. 혹시 너도 동물이 되어보고 싶은 적 없어? 하루동안 동물이 된다면, 어떤 동물이 되고싶니?",),
                ),
                Container(
                  child : GirinSpeak()
                ),
                // ---- front camera
                // Transform(
                //   alignment: Alignment.topRight,
                //   transform: Matrix4.diagonal3Values(0.3, 0.3, 0), // (x,y,z)
                //   child:
                //     Container(
                //       padding: EdgeInsets.symmetric(
                //         vertical: ScreenUtil().setHeight(64),
                //         horizontal: ScreenUtil().setWidth(19)
                //       ),
                //       child:CameraPreview(_controller),
                //     ),
                // ),
                Positioned(
                  top: ScreenUtil().setHeight(64),
                  right: ScreenUtil().setWidth(10),
                  child:
                    Container(
                      height: ScreenUtil().setHeight(190),
                      width: ScreenUtil().setWidth(120),
                      child:CameraPreview(_controller),
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
                        //child: Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(12),),textAlign: TextAlign.center,),
                        //Text("00:00:00", style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(12),),textAlign: TextAlign.center,),
                      ),
                      SizedBox( 
                        width: ScreenUtil().setWidth(375),
                        height: 18,
                        // child: Text("hi"),
                      ),
                      Row(
                        children: [
                          !isDisabled ? ChangeCameraView() : Container(
                            width: ScreenUtil().setWidth(38),
                            height: ScreenUtil().setHeight(38),
                            color: Colors.transparent
                          ),
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

                                  //GallerySaver.saveVideo(filePath);
                                }
                              });
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
                                filePath = join(
                                    (await getApplicationDocumentsDirectory())
                                        .path,
                                    '${DateTime.now()}.mp4');
                                setState(() {
                                  startstopwatch();
                                  //ChangeCameraView();
                                  _controller
                                      .startVideoRecording(filePath); //filePath);
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
                          // if isDisable is not true, recording
                          !isDisabled ? Container(
                            width: ScreenUtil().setWidth(38),
                            height: ScreenUtil().setHeight(38),
                            color: Colors.transparent
                          ) : SaveVideo(),
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
                        //padding: EdgeInsets.all(15.0),
                      child: Image.asset(
                          "assets/icons/cancel.png",
                      ),
                    ),
                  )
                ),
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

class GirinHi extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Align(
      alignment : Alignment.center ,
      child: Container(
        width: ScreenUtil().setWidth(512),
        height: ScreenUtil().setHeight(512),
        child : Image.asset("assets/avatars/hi.gif",
            fit : BoxFit.cover),
      )
    );
  }
}
class GirinSpeak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 2000)),
        builder: (context, snapshot) {
        // Checks whether the future is resolved, ie the duration is over
          if (snapshot.connectionState == ConnectionState.done){
            girinchange = false;
            return Align(
                alignment : Alignment.center ,
                child: Container(
                  width: ScreenUtil().setWidth(512),
                  height: ScreenUtil().setHeight(512),
                  child : Image.asset("assets/avatars/speaking.gif",
                      fit : BoxFit.cover),
                )
            );}
          else if(girinchange == true) {
            return GirinHi();
          }
          else
            return Align(
                alignment : Alignment.center ,
                child: Container(
                  width: ScreenUtil().setWidth(512),
                  height: ScreenUtil().setHeight(512),
                  child : Image.asset("assets/avatars/speaking.gif",
                      fit : BoxFit.cover),
                )
            );
        // Return empty container to avoid build errors
        }
    );
  }
}

class ChangeCameraView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (cameraview == true){
            cameraview = false;
          }
          else{
            cameraview = true;
          }
        },
        child: Container(
          width: ScreenUtil().setWidth(38),
          height: ScreenUtil().setHeight(38),
          //padding: EdgeInsets.all(15.0),
          child: Image.asset(
            "assets/icons/changeCamera.png",
          ),
      ),
    ));
  }
}

class SaveVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          //SaveVideo();
        },
        child: Container(
          width: ScreenUtil().setWidth(38),
          height: ScreenUtil().setHeight(38),
          //padding: EdgeInsets.all(15.0),
          child: Image.asset(
            "assets/icons/saveVideo.png",
          ),
        ),
      )
    );
  }
}

/*"/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4"*/
// Future<String> _startVideoRecording() async {
//
//   if (!_controller.value.isInitialized) {
//
//     return null;
//
//   }
//
//   // Do nothing if a recording is on progress
//
//   if (_controller.value.isRecordingVideo) {
//
//     return null;
//
//   }
//   //get storage path
//
//   final Directory appDirectory = await getApplicationDocumentsDirectory();
//
//   final String videoDirectory = '${appDirectory.path}/Videos';
//
//   await Directory(videoDirectory).create(recursive: true);
//
//   final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
//
//   final String filePath = '$videoDirectory/${currentTime}.mp4';
//
//
//
//   try {
//
//     await _controller.startVideoRecording(filePath);
//     GallerySaver.saveVideo(filePath);
//
//   } on CameraException catch (e) {
//
//
//     return null;
//
//   }
//
//
//   //gives you path of where the video was stored
//   return filePath;
//
// }
//
//
//
//
//

//   return AspectRatio(
//       aspectRatio: 1,
//       child: Transform(
//         alignment: Alignment.bottomRight,
//         transform: Matrix4.diagonal3Values(0.3, 0.3, 0),
//         // (x,y,z)
//         child: CameraPreview(_controller),
//       )
//   );

//
// // 사용자가 촬영한 사진을 보여주는 위젯
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;
//
//   const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the Picture')),
//       // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
//       // 경로로 `Image.file`을 생성하세요.
//       body: Image.file(File(imagePath)),
//     );
//
//   }
// }

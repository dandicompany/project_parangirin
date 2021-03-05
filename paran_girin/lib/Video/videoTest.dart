import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:lottie/lottie.dart';
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

class Initialization extends StatefulWidget{

  @override
  InitializationState createState() => InitializationState();
  
}

class InitializationState extends State<Initialization>{
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
  Stopwatch _stopwatch;

  bool isDisabled = false;

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
    _stopwatch = Stopwatch();
    // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {});    // re-render the page
  }

  @override
  Widget build(BuildContext context) {
    int hour = 0;
    int min = 0;
    int sec = 0;
    return Scaffold(
      //debugShowCheckedModeBanner: false,
        //appBar: AppBar(title: Text('Take a Video')),
        body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    Align(
                      child:
                        textToSpeech(text: "안녕 호빈 친구",),
                    ),
                    Align(
                      alignment: Alignment(0.0,0.73),
                      child: Container(
                        width: ScreenUtil().setWidth(79),
                        height: ScreenUtil().setHeight(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.grey,
                            borderRadius: BorderRadius.all( Radius.circular(40), ),
                        ),
                        alignment: Alignment.center,
                        child: Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(12),),textAlign: TextAlign.center,),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.topRight,
                      transform: Matrix4.diagonal3Values(0.3, 0.3, 0), // (x,y,z)
                      child: CameraPreview(_controller),
                    ),
                    Align(
                      alignment : Alignment.bottomCenter,
                      child:!_controller.value.isRecordingVideo
                      ? RawMaterialButton(onPressed: () async {
                        try{
                          await _initializeControllerFuture;
                          filePath = join((await getApplicationDocumentsDirectory()).path,
                              '${DateTime.now()}.mp4'
                          );
                          print(filePath);
                            setState(() {
                              handleStartStop();
                              _controller.startVideoRecording(filePath);//filePath);
                              isDisabled = true;
                              isDisabled = !isDisabled;
                            });
                            }catch(e){
                            print(e);
                        }

                      },
                        child : ImageIcon(AssetImage("assets/images/video_On.png"), size : ScreenUtil().radius(70), color: Colors.red,),
                        padding: EdgeInsets.all(15.0),
                        shape:  CircleBorder(),
                      )
                    :null,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child : _controller.value.isRecordingVideo?
                          RawMaterialButton(onPressed: (){
                            setState((){
                              if(_controller.value.isRecordingVideo){
                                handleStartStop();
                                _controller.stopVideoRecording();
                                isDisabled = false;
                                isDisabled = !isDisabled;
                                GallerySaver.saveVideo(filePath);
                              }
                            });
                          },
                            child: ImageIcon(AssetImage("assets/images/video_Off.png"),size :  ScreenUtil().radius(70) ,color: Colors.red,),
                            padding : EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ):null
                        ,
                    ),
                    Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(488),
                      child: Lottie.asset('assets/avatars/data.json'),
                    ),
                  ]
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            },
        ),
    );
  }
}


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


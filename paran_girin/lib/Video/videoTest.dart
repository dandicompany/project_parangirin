import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CameraDescription camera;
CameraDescription firstCamera;
CameraDescription frontCamera;



Future<void> videoFunc() async {
  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  firstCamera = cameras.first;
  final frontCamera = cameras[1];

  runApp(
    MaterialApp(
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(66)),
          //ss_babyInfoTitle(),
          SizedBox(height: ScreenUtil().setHeight(10)),
          //_loginDescription(),
          SizedBox(height: ScreenUtil().setHeight(28)),
          //_babyNameInput(),
          SizedBox(height: ScreenUtil().setHeight(41)),
          //_babyAgeInput(),
          SizedBox(height: ScreenUtil().setHeight(75)),
         // _babyInfoButton(),
        ],
      ),
    );
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
        appBar: AppBar(title: Text('Take a Video')),
        body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Transform(
                  alignment: Alignment.bottomRight,
                  transform: Matrix4.diagonal3Values(0.3, 0.3, 0), // (x,y,z)
                  child: CameraPreview(_controller),
                );
              }

              else{
                return Center(child: CircularProgressIndicator());
              }
            },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async{

          // if (_controller.value.isInitialized){
          // return null;
          // }
          //
          // if(_controller.value.isRecordingVideo){
          // return null;
          // }

          final Directory appDirectory = await getApplicationDocumentsDirectory();
          final String videoDirectory = '${appDirectory.path}/Videos';
          await Directory(videoDirectory).create(recursive : true);
          final String currentTime = DateTime.now().microsecondsSinceEpoch.toString();
          final String filePath = '$videoDirectory/${currentTime}.mp4';

          print("filePath : " + filePath);


          try{
          await _controller.startVideoRecording();//.then(path : filePath);
          String videoPath = filePath;
          } on CameraException catch(e) {
          // showCameraException(e);
          // return null;
          }

          return filePath;



    //   try{
        // await _initializeControllerFuture;
        // final path = join(
        // (await getTemporaryDirectory()).path,
        // '${DateTime.now()}.mp4'
        // );
        // // await _controller.takePicture();
        // // Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: path),
        // //
        // //
        // //   ),
        // // );
        //   !(num%2 == 0) ? {
        //     num = num+1,
        //     _controller.prepareForVideoRecording(),
        //     _controller.startVideoRecording(),
        //   }
        //   :_controller.stopVideoRecording();
        // }
        // catch(e){
        // print(e);
        // }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}



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


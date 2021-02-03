import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppTheme.colors.primary1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '안녕하세요',
            ),
            Text(
              '안녕하세요',
              style: TextStyle(
                fontFamily: 'Noto Sans KR',
                ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/



import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){

  func();
  runApp(MyApp());
}

Future<void> func() async {
  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  print('냐ㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑ'+cameras.first.toString());
  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  final firstCamera = cameras.first;
  final frontCamera = cameras[1];
  // TakePictureScreen(camera : firstCamera);
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
        camera: firstCamera,
      ),
    ),
  );


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          fontFamily: 'Noto Sans KR',
        ),
        // 여기 공부
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginPage(),

        },
        //
        home: LoginPage(), // for tab test home: DefaultLayout(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
  //  printScreenInformation();
  return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(66)),
          _loginTitle(),
          SizedBox(height: ScreenUtil().setHeight(111)),
          _loginDescription(),
          SizedBox(height: ScreenUtil().setHeight(28)),
          _loginInput(),
          SizedBox(height: ScreenUtil().setHeight(41)),
          _loginWarning(),
          SizedBox(height: ScreenUtil().setHeight(75)),
          _loginSNSText(),
          SizedBox(height: ScreenUtil().setHeight(75)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              _facebookButton(),
              _googleButton(),
            ]
          ),
          SizedBox(height: ScreenUtil().setHeight(75)),
          //_loginButton()
          SizedBox(
            width: ScreenUtil().setWidth(375),
            height: ScreenUtil().setHeight(55),
            child: RaisedButton(
              color: AppTheme.colors.primary2,
              child: Text('다음',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18)
                  ),
                ),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BabyInfo()));
              }
            //child: null
            )
          )
        ],
      ),
    );
  }
}

Widget _loginTitle() {
  return Container(
    alignment: Alignment.topLeft,
    height: ScreenUtil().setHeight(70),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16)
    ),
    child: Container(
      width: ScreenUtil().setWidth(180),
      child:
        Text('파란기린은\n당신을 환영해요!',
        style: TextStyle(
        // fontFamily: 'Noto Sans KR',
        fontWeight: FontWeight.w300,
        fontSize: ScreenUtil().setSp(24)),
      ),
    ),
  );
}

Widget _loginDescription() {
  return Container(
    alignment: Alignment.topLeft,
    height: ScreenUtil().setHeight(46),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16)
    ),
    child: Container(
      width: ScreenUtil().setWidth(188),
      child:
        Text('로그인 혹은 회원가입을 위해 이메일을 입력해 주세요',
        style: TextStyle(
        // fontFamily: 'Noto Sans KR',
        // fontWeight: FontWeight.w300,
        fontSize: ScreenUtil().setSp(16)),
      ),
    ),
  );
}

Widget _loginInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: "paran@girin.com",
      hintStyle: TextStyle(
        fontSize: ScreenUtil().setSp(16)
      )
    ),
    keyboardType: TextInputType.emailAddress,
   // obscureText: true, // for password
  );
}

Widget _loginWarning() {
  return Container(
    height: ScreenUtil().setHeight(34),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16)
    ),
    child: Container(
      width: ScreenUtil().setWidth(250),
      child:
        Align(
          child: RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              style: TextStyle(
              // fontFamily: 'Noto Sans KR',
              // fontWeight: FontWeight.w300,
              color: AppTheme.colors.base2,
              fontSize: ScreenUtil().setSp(12)
              ),
              children: <TextSpan>[
                new TextSpan(text: '계속 진행하면 파란기린의 '),
                new TextSpan(text: '이용 약관과 개인정보 처리 방침에 동의',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: '한 것으로 간주됩니다.')
              ],
            )
          ),
        ),
    ),
  );
}

Widget _loginSNSText() {
  return Container(
    alignment: Alignment.topLeft,
    height: ScreenUtil().setHeight(20),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16),
    ),
    child: Container(
      width: ScreenUtil().setWidth(180),
      child:
        Align(
          alignment: Alignment.bottomRight,
          child: Text('혹은 SNS 계정으로 함께 해요',
            style: TextStyle(
            // fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(14)),
          ),
        ),
    ),
  );
}

Widget _facebookButton() {
  return Ink(
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.ac_unit),
        iconSize: 40.0,  // * screenUtil 씌워줘야함
        onPressed: (){},
      )

  );
}

Widget _googleButton() {
  return Ink(
    decoration: ShapeDecoration(
      color: AppTheme.colors.base3,
      shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.access_alarm),
        iconSize: 40.0,  // * screenUtil 씌워줘야함
        onPressed: (){},
      )

  );
}

Widget _loginButton() {
  return SizedBox(
    width: ScreenUtil().setWidth(375),
    height: ScreenUtil().setHeight(55),
    child: RaisedButton(
      color: AppTheme.colors.primary2,
      child: Text('다음',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(18)
          ),
        ),
      textColor: Colors.white,
      onPressed: (){
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => BabyInfoPage()));
      }
    )
  );
}

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
      ResolutionPreset.medium,
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
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        _controller.value.aspectRatio,
        child: CameraPreview(_controller));
  }

// return Scaffold(
//   appBar: AppBar(title: Text('Take a picture')),
//   // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
//   // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
//   body: FutureBuilder<void>(
//     future: _initializeControllerFuture,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         // Future가 완료되면, 프리뷰를 보여줍니다.
//         return CameraPreview(_controller);
//       } else {
//         // 그렇지 않다면, 진행 표시기를 보여줍니다.
//         return Center(child: CircularProgressIndicator());
//       }
//     },
//   ),
//   floatingActionButton: FloatingActionButton(
//     child: Icon(Icons.camera_alt),
//     // onPressed 콜백을 제공합니다.
//     onPressed: () async {
//       // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
//       // 대응할 수 있습니다.
//       try {
//         // 카메라 초기화가 완료됐는지 확인합니다.
//         await _initializeControllerFuture;
//
//         // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
//         final path = join(
//           // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
//           // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
//           (await getTemporaryDirectory()).path,
//           '${DateTime.now()}.png',
//         );
//
//         // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
//        /* await _controller.takePicture(path);*/
//
//         // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DisplayPictureScreen(imagePath: path),
//           ),
//         );
//       } catch (e) {
//         // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
//         print(e);
//       }
//     },
//   ),
// );
//}
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      //  body: Image.file(File(imagePath)),
    );
  }
}

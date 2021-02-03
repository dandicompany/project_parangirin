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


List<CameraDescription> cameras;

void main(){
  runApp(MyApp());

  Future<void> func() async {
    // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
    cameras = await availableCameras();

    // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
    final firstCamera = cameras.first;
    final frontCamera = cameras[1];

  /*  runApp(
      MaterialApp(
        theme: ThemeData.dark(),
        home: TakePictureScreen(
          // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
          camera: firstCamera,
        ),
      ),
    );
  */
  }
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

                  /////////////////////////////////
                  builder: (context) => TakePictureScreen(
                    // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
                    camera: cameras[1]
                  )));
                  ////////////////////////////////
              } //,BabyInfo()
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


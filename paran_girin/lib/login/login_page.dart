import 'package:flutter/material.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
void main() => runApp(MyApp());

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
        home: LoginPage(title: 'ParanGirin Login'),
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
          _loginButton()
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
      width: ScreenUtil().setWidth(165),
      child: 
        Text('파란기린은 당신을 환영해요!',
        style: TextStyle(
        // fontFamily: 'Noto Sans KR',
        fontWeight: FontWeight.w300,
        fontSize: 24.0),
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
        fontSize: 16.0),
      ),
    ),
  );
}

Widget _loginInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: "paran@girin.com",
      hintStyle: TextStyle(
        fontSize: 16.0
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
          child: Text('계속 진행하면 파란기린의 이용 약관과 개인정보 처리 방침에 동의한 것으로 간주됩니다.',
            style: TextStyle(
            // fontFamily: 'Noto Sans KR',
            // fontWeight: FontWeight.w300,
            color: AppTheme.colors.base2,
            fontSize: 12.0),
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
      width: ScreenUtil().setWidth(165),
      child: 
        Align(
          alignment: Alignment.bottomRight,
          child: Text('혹은 SNS 계정으로 함께 해요',
            style: TextStyle(
            // fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w500,
            fontSize: 14.0),
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
          fontSize: 18.0
          ),
        ),
      textColor: Colors.white,
      onPressed: (){}, 
    //child: null
    )
  );
}
*/
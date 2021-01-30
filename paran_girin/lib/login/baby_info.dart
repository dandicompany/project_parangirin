import 'package:flutter/material.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*

class BabyInfo extends StatefulWidget {
  @override
  _BabyInfoState createState() => _BabyInfoState();
}

class _BabyInfoState extends State<BabyInfo> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baby Info',
        theme: ThemeData(
          fontFamily: 'Noto Sans KR',
        ),
      ),
    );
  }
}

*/

class BabyInfoPage extends StatefulWidget {
  const BabyInfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BabyInfoPageState createState() => _BabyInfoPageState();
}

class _BabyInfoPageState extends State<BabyInfoPage> {
  @override
  Widget build(BuildContext context) {
  //  printScreenInformation();
  return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(66)),
          _babyInfoTitle(),
          SizedBox(height: ScreenUtil().setHeight(10)),
          _loginDescription(),
          SizedBox(height: ScreenUtil().setHeight(28)),
          _babyNameInput(),
          SizedBox(height: ScreenUtil().setHeight(41)),
          _babyAgeInput(),
          SizedBox(height: ScreenUtil().setHeight(75)),
          _babyInfoButton(),
        ],
      ),
    );
  }
}
  
Widget _babyInfoTitle() {
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
        Text('파란기린이 아이에 대해 궁금해 해요.',
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
        Text('아이의 이름과 나이를 입력해 주세요.',
        style: TextStyle(
        // fontFamily: 'Noto Sans KR',
        // fontWeight: FontWeight.w300,
        fontSize: 12.0),
      ),
    ),
  );
}

Widget _babyNameInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: "아이 이름",
      hintStyle: TextStyle(
        fontSize: 16.0
      )
    ),
    keyboardType: TextInputType.name,
   // obscureText: true, // for password
  );
}

Widget _babyAgeInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: "아이 나이",
      hintStyle: TextStyle(
        fontSize: 16.0
      )
    ),
    keyboardType: TextInputType.number,
   // obscureText: true, // for password
  );
}

Widget _babyInfoButton() {
  return SizedBox(
    width: ScreenUtil().setWidth(375),
    height: ScreenUtil().setHeight(55),
    child: RaisedButton(
      color: AppTheme.colors.primary2,
      child: Text('가입 완료하기',
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

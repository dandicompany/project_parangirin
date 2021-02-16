import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BabyInfoAdd extends StatefulWidget {
  const BabyInfoAdd({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BabyInfoState createState() => _BabyInfoState();
}

class _BabyInfoState extends State<BabyInfoAdd> {
  @override
  Widget build(BuildContext context) {
  //  printScreenInformation();
  return Scaffold(
      body: Column(
        children: <Widget>[
          // SizedBox(height: ScreenUtil().setHeight(66)),
          // _babyInfoTitle(),
          // SizedBox(height: ScreenUtil().setHeight(10)),
          // _loginDescription(),
          // SizedBox(height: ScreenUtil().setHeight(28)),
          // _babyNameInput(),
          // SizedBox(height: ScreenUtil().setHeight(41)),
          // _babyAgeInput(),
          // SizedBox(height: ScreenUtil().setHeight(75)),
          // _babyInfoButton(context),
          _babyInfoTitle(),
          SizedBox(height: ScreenUtil().setHeight(84)),
          _babyInfoInput(),
          SizedBox(height: ScreenUtil().setHeight(84)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultButton(
              text: "완료하기",
              press: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DefaultLayout()));
              },
            ),
          )
        ],
      ),
    );
  }
}
  
/*
Widget _babyInfoTitle() {
  return Container(
    alignment: Alignment.topLeft,
    height: ScreenUtil().setHeight(70),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16)
    ),
    child: Container(
      width: ScreenUtil().setWidth(300),
      child: 
        Text('파란기린이 \n아이에 대해 궁금해 해요.',
        style: TextStyle(
        // fontFamily: 'Noto Sans KR',
        fontWeight: FontWeight.w300,
        fontSize: ScreenUtil().setSp(24)
        ),
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
        fontSize: ScreenUtil().setSp(12)),
      ),
    ),
  );
}

Widget _babyNameInput() {
  return TextField(
    decoration: InputDecoration(
      hintText: "아이 이름",
      hintStyle: TextStyle(
        fontSize: ScreenUtil().setSp(16)
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
        fontSize: ScreenUtil().setSp(16)
      )
    ),
    keyboardType: TextInputType.number,
   // obscureText: true, // for password
  );
}

Widget _babyInfoButton(context) {
  return SizedBox(
    width: ScreenUtil().setWidth(375),
    height: ScreenUtil().setHeight(55),
    child: RaisedButton(
      color: AppTheme.colors.primary2,
      child: Text('가입 완료하기',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(18)
          ),
        ),
      textColor: Colors.white,
      onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DefaultLayout()));
        }  
    //child: null
    )
  );
}

*/

Widget _babyInfoTitle() {
  return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(70),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "파란기린이 \n아이에 대해 궁금해 해요.",
              style: TextStyle(
                // fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(24)
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(10),
            ),
            Text(
              "아이의 이름과 나이를 입력해 주세요.",
              style: TextStyle(
                // fontFamily: 'Noto Sans KR',
                // fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(12)
              ),
            ),
          ]
        ),
      ),
  );
}

Widget _babyInfoInput() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(36)),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              "아이의 이름은  ",
              style: TextStyle(
                color: AppTheme.colors.base3,
                fontSize: ScreenUtil().setSp(18)
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(106),
              child: TextField(
                keyboardType: TextInputType.name,
              ),
            ),
            Text(
              "(이)에요.",
              style: TextStyle(
                color: AppTheme.colors.base3,
                fontSize: ScreenUtil().setSp(18)
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(36)),
        Row(
          children: [
            Text(
              "현재  ",
              style: TextStyle(
                color: AppTheme.colors.base3,
                fontSize: ScreenUtil().setSp(18)
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(98),
              child: TextField(
                keyboardType: TextInputType.name,
              ),
            ),
            Text(
              "개월이에요.",
              style: TextStyle(
                color: AppTheme.colors.base3,
                fontSize: ScreenUtil().setSp(18)
              ),
            ),
          ],
        )
      ],
    ),
  );
}
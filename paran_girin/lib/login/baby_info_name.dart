import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/baby_info_nickname.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BabyInfoName extends StatefulWidget {
  const BabyInfoName({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BabyInfoNameState createState() => _BabyInfoNameState();
}

class _BabyInfoNameState extends State<BabyInfoName> {
  TextEditingController _textCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  printScreenInformation();
    return Scaffold(
      body: Column(
        children: <Widget>[
          _babyInfoTitle(),
          SizedBox(height: ScreenUtil().setHeight(38)),
          _babyInfoInput("김기린", _textCon),
          SizedBox(height: ScreenUtil().setHeight(170)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultButton(
              text: "다음",
              press: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BabyInfoNickname(_textCon.text)));
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _babyInfoTitle() {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(70),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "파란기린이 \n아이에 대해 궁금해 해요.",
          style: TextStyle(
              // fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w300,
              fontSize: ScreenUtil().setSp(24)),
        ),
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(89),
        ),
        Text(
          "아이의 이름을 알려주세요.",
          style: TextStyle(
              // fontFamily: 'Noto Sans KR',
              // fontWeight: FontWeight.w300,
              fontSize: ScreenUtil().setSp(18)),
        ),
      ]),
    ),
  );
}

Widget _babyInfoInput(text, TextEditingController _con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
    child: TextField(
      controller: _con,
      decoration: InputDecoration(
          // hintText: "김기린",
          hintText: text,
          hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18))),
      keyboardType: TextInputType.name,
      // obscureText: true, // for password
    ),
  );
}

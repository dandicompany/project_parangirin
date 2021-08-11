import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/baby_info_nickname.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              _babyInfoTitle(),
              SizedBox(height: ScreenUtil().setHeight(38)),
              _babyInfoInput("김기린", _textCon, () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BabyInfoNickname(_textCon.text)));
                },),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.colors.primary2,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BabyInfoNickname(_textCon.text)));
                },
                height: ScreenUtil().setHeight(65),
                child: Text(
                  "다음",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                )
              )
            )
          )
        ],
      ),
    );
  }
}

Widget _babyInfoTitle() {
  return Padding(
    padding: EdgeInsets.only(
        top: ScreenUtil().setWidth(90),
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
  );
}

Widget _babyInfoInput(text, TextEditingController _con, next) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
    child: TextFormField(
      controller: _con,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
                  next();
                },
      decoration: InputDecoration(
        // hintText: "김기린",
        hintText: text,
        hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18)),
        suffixIcon: IconButton(
          onPressed: _con.clear,
          icon: SvgPicture.asset("assets/icons/close.svg"),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
        ),
      ),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: ScreenUtil().setSp(18))
      // obscureText: true, // for password
    ),
  );
}

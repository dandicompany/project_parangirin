import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

bool button1 = false;
bool button2 = false;
bool button3 = false;
bool allbutton = false;

double buttonscale = 0.7;
class PrivacyPolicy2 extends StatefulWidget {
  @override
  _PrivacyPolicy createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: [

          Container(
            height: ScreenUtil().setHeight(464),
            width: ScreenUtil().setWidth(343),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(22)),
                Text("사용약관", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Noto Sans KR'),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: buttonscale,
                      child: CircularCheckBox(
                        value: button1,
                        onChanged: (bool value) {
                          setState(() {
                            button1 = !button1;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(4),),
                    Text("아래 이용 약관 및 개인 정보 처리 방침에 동의합니다.",
                        style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0)),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: buttonscale,
                      child: CircularCheckBox(
                        value: button2,
                        onChanged: (bool value) {
                          setState(() {
                            button2 = !button2;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(4),),
                    Text("파란기린 이용 약관",style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: ScreenUtil().setWidth(49.0),),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      width: ScreenUtil().setWidth(275),
                      child: SingleChildScrollView(
                          child:Text("이 약관은 단디 팀이 운영하는 파란기린 모바일 어플리케이션(이하 “앱”)의 서비스를 이용함에 있어 팀과 이용자의 권리의무 및 책임사항을 규정함을 목적으로 합니다. 이 약관은 단디 팀이 운영하는 파란기린 모바일 어플리케이션(이하 “앱”)의 서비스를 이용함에,", style: TextStyle(color: Colors.black,
                              fontSize: 12.0))),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: buttonscale,
                      child: CircularCheckBox(
                        value: button3,
                        onChanged: (bool value) {
                          setState(() {
                            button3 = !button3;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(4),),
                    Text("파란기린 이용 약관",style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: ScreenUtil().setWidth(49.0),),
                    Container(
                      height: ScreenUtil().setHeight(100),
                      width: ScreenUtil().setWidth(275),
                      child: SingleChildScrollView(
                          child:Text("파란기린은 단디 팀이 운영하는 서비스로, 팀은 파란기린 서비스 제공과 관련하여 귀하의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 팀은 팀이 서비스(이용약관에서 정의됨)를 통하여 이용자로부터 수집하는 개인정보(아래에서 정의됨)의 처리에 대해 설명하기 위해 본 개인정보처리방침을 작성하였습니다.", style: TextStyle(color: Colors.black,
                              fontSize: 12.0))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}


// CheckboxListTile(
// title: Text("아래 이용 약관 및 개인 정보 처리 방침에 동의합니다.",
// style: TextStyle(color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: 12.0)),
// value: button1,
// controlAffinity:ListTileControlAffinity.leading,
// contentPadding: EdgeInsets.symmetric(horizontal: .0) ,
// onChanged: (bool value) {
// setState(() {
// button1 = value;
//
// });
// },
// ),
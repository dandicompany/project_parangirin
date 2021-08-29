import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/login/auth_page.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/theme/app_theme.dart';

bool button1 = false;
bool button2 = false;
bool button3 = false;
bool allbutton = false;
bool total = false;

double buttonscale = 1;
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
          _background(),
          Positioned(
              left: ScreenUtil().setWidth(16),
            top: ScreenUtil().setHeight(190),
            child:Container(
              height: ScreenUtil().setHeight(540),
              width: ScreenUtil().setWidth(343),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(
                  //   //color: Colors.black,
                  //   width: 0.3,
                  // ),
                  color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(22)),
                  Text("사용약관", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Noto Sans KR'),),
                  SizedBox(height: ScreenUtil().setHeight(24)),
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
                              if (button1 == true && button2 == true && button3==true){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                              };
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
                  SizedBox(height: ScreenUtil().setHeight(20)),
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
                              if (button1 == true && button2 == true && button3==true){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                              };
                            });
                          },
                        ),
                      ),
                      //SizedBox(width: ScreenUtil().setWidth(2),),
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
                  SizedBox(height: ScreenUtil().setHeight(10)),
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
                              if (button1 == true && button2 == true && button3==true){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                              };
                            });
                          },
                        ),
                      ),
                      //SizedBox(width: ScreenUtil().setWidth(),),
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
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  Stack(
                    children: [
                      SizedBox(width: double.infinity,
                        height: ScreenUtil().setHeight(30),
                        child: ColoredBox(color: Colors.grey,)),
                      SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(53),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),),
                          child: Text('동의합니다', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                          onPressed: () => {
                            setState(() {
                              button1 = true;
                              button2 = true;
                              button3 = true;
                              if (button1 == true && button2 == true && button3==true){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                              };
                            }),
                          },
                          color: Colors.grey,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
          ),
          ),

      ],
      )
    );
  }
  Widget _buildLoginBody() {
        return Container(
            child: Padding(
            padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(90),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    "파란기린은\n당신을 환영해요!",
                    style: TextStyle(
                    //fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(24)),
                    ),
    ])));
  }

  Widget _background(){
    return Stack(
      children: [
        _buildLoginBody(),
        Opacity(
          opacity: 0.25,
          child: Container(
          decoration: BoxDecoration(color: Colors.black),
          ),),
      ],
    );
  }
}

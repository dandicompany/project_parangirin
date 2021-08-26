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
      body : Container(
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
                Text("아래 이용 약관 및 개인 정보 처리 방침에 동의합니다.",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0)),
              ],
            )
          ],
        ),
      ),
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
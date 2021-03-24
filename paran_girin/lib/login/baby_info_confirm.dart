import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/baby_info_name.dart';
import 'package:paran_girin/login/baby_info_profile.dart';
import 'package:paran_girin/myPageDetail/childrenInfo.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/models/schema.dart';

class BabyInfoConfirm extends StatefulWidget {
  @override
  _BabyInfoConfirmState createState() => _BabyInfoConfirmState();
}

class _BabyInfoConfirmState extends State<BabyInfoConfirm> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    UserModel _info = fp.getUserInfo();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(64),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "추가하고 싶은 자녀가 있나요? ",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: AppTheme.colors.base2),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BabyInfoName()));
                    },
                    child: Text(
                      "자녀 추가하기",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(14),
                          color: AppTheme.colors.primary2),
                    ))
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(101)),
            Text(
              "아이의 이름은 ${_info.currentChild.name} 이에요\n\n파란기린은 아이를 ${_info.currentChild.nickName} (이)라고 부를게요\n\n${_info.currentChild.nickName} 은(는) ${DateTime.fromMicrosecondsSinceEpoch(_info.currentChild.birthday)} 에 태어났어요",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16.0),
                  fontWeight: FontWeight.w300,
                  color: AppTheme.colors.base1),
            ),
            SizedBox(height: ScreenUtil().setHeight(96)),
            DefaultButton(
              text: "완료",
              press: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => childrenInfo()));
              },
            )
          ],
        ),
      ),
    );
  }
}

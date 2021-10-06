import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/login/auth_page.dart';
import 'package:paran_girin/login/baby_info_name.dart';
import 'package:paran_girin/myPageDetail/childrenInfo.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/models/schema.dart';

DateFormat dateFormat = DateFormat("yyyy년 MM월 dd일");

class BabyInfoConfirm extends StatefulWidget {
  final String name, nickName;
  final int birthdate;

  BabyInfoConfirm(this.name, this.nickName, this.birthdate);

  
  @override
  _BabyInfoConfirmState createState() => _BabyInfoConfirmState(name, nickName, birthdate);
}

class _BabyInfoConfirmState extends State<BabyInfoConfirm> {
  FirebaseProvider fp;
  String name, nickName;
  int birthdate;
  _BabyInfoConfirmState(this.name, this.nickName, this.birthdate);

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    UserModel _info = fp.getUserInfo();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
                  "아이의 이름은 ${this.name}(이)에요\n\n파란기린은 아이를 ${this.nickName}(이)라고 부를게요\n\n${this.nickName}은(는) ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(this.birthdate))} 에 태어났어요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16.0),
                      fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base1),
                ),
                // SizedBox(height: ScreenUtil().setHeight(96)),
                // DefaultButton(
                //   text: "완료",
                //   press: () {
                //     Navigator.of(context).pushReplacement(
                //         MaterialPageRoute(builder: (context) => ChildrenInfo()));
                //   },
                // )
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.colors.primary2,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  await fp.addChild(this.name, this.nickName, this.birthdate);
                  await fp.getFAnalytics().logEvent(name: 'button_click', parameters: <String, String>{'button': 'register/complete'});
                  await fp.reloadUser();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AuthPage(),
                      settings: RouteSettings(name: 'home'),
                    ));
                  // Navigator.of(context).pop();
                },
                height: ScreenUtil().setHeight(65),
                child: Text(
                  "완료하기",
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

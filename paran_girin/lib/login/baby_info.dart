import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BabyInfo extends StatefulWidget {
  const BabyInfo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BabyInfoState createState() => _BabyInfoState();
}

class _BabyInfoState extends State<BabyInfo> {
  FirebaseProvider fp;
  TextEditingController _nameCon = TextEditingController();
  TextEditingController _ageCon = TextEditingController();
  String name, nickname;
  int birthday;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          _babyInfoTitle(),
          SizedBox(height: ScreenUtil().setHeight(84)),
          _babyInfoInput(),
          SizedBox(height: ScreenUtil().setHeight(84)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultButton(
              text: "가입 완료하기",
              press: () {
                logger.d("before adding child");
                fp.addChild(_nameCon.text, _ageCon.text, null);
                //fp.reloadUser();
              },
            ),
          )
        ],
      ),
    );
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
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            "아이의 이름과 나이를 입력해 주세요.",
            style: TextStyle(
                // fontFamily: 'Noto Sans KR',
                // fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(12)),
          ),
        ]),
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
                    fontSize: ScreenUtil().setSp(18)),
              ),
              Container(
                width: ScreenUtil().setWidth(106),
                child: TextField(
                  controller: this._nameCon,
                  keyboardType: TextInputType.name,
                ),
              ),
              Text(
                "(이)에요.",
                style: TextStyle(
                    color: AppTheme.colors.base3,
                    fontSize: ScreenUtil().setSp(18)),
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
                    fontSize: ScreenUtil().setSp(18)),
              ),
              Container(
                width: ScreenUtil().setWidth(98),
                child: TextField(
                  controller: this._ageCon,
                  keyboardType: TextInputType.name,
                ),
              ),
              Text(
                "개월이에요.",
                style: TextStyle(
                    color: AppTheme.colors.base3,
                    fontSize: ScreenUtil().setSp(18)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

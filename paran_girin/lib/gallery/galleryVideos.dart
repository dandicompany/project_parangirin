// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/gallery/myVideoLayout.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:paran_girin/gallery/videoShowWidget.dart';
import 'package:paran_girin/layout/default_icon_botton.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/layout/flatbuttonShadow.dart';

int bodyNum = 0;
int natureNum = 0;
int exerciseNum = 0;
int socialNum = 0;

int sum = bodyNum + natureNum + exerciseNum + socialNum;

class galleryVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<galleryVideo> {
  bool buttonClickedState = true;
  bool buttonClickedState2 = true;
  bool buttonClickedState3 = true;
  bool buttonClickedState4 = true;

  //영상 개수 가져오기
  @override
  void initState() {
    super.initState();
    sum = 3;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(40),
            ),
            Row(
              children: [
                CustomElevation(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        buttonClickedState = !buttonClickedState;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: ScreenUtil().setWidth(164),
                    height: ScreenUtil().setHeight(71),
                  ),
                  text1: "신체",
                  text2: bodyNum.toString() + "개의 영상",
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                CustomElevation(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        buttonClickedState2 = !buttonClickedState2;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: ScreenUtil().setWidth(164),
                    height: ScreenUtil().setHeight(71),
                  ),
                  text1: "자연 탐구",
                  text2: natureNum.toString() + "개의 영상",
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Row(
              children: [
                CustomElevation(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        buttonClickedState3 = !buttonClickedState3;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: ScreenUtil().setWidth(164),
                    height: ScreenUtil().setHeight(71),
                  ),
                  text1: "운동",
                  text2: bodyNum.toString() + "개의 영상",
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                CustomElevation(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        buttonClickedState3 = !buttonClickedState3;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minWidth: ScreenUtil().setWidth(164),
                    height: ScreenUtil().setHeight(71),
                  ),
                  text1: "사회 관계",
                  text2: natureNum.toString() + "개의 영상",
                ),
              ],
            ),
            sum == 0 ? noVideo() : yesVideo(),
          ],
        ),
      ),
    );
  }
}

class noVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(66),
          ),
          Image.asset(
            "assets/images/noVideoGirin.png",
            width: ScreenUtil().setHeight(132),
            height: ScreenUtil().setWidth(132),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(17),
          ),
          Text(
            "아직 촬영한 영상이 없어요",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(16), fontFamily: 'Noto Sans KR'),
          ),
          SizedBox(height: ScreenUtil().setHeight(80)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultIconButton(
                text: "파란 기린과 대화하기 ",
                isInvert: false,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Initialization()));
                }),
          )
        ],
      ),
    );
  }
}

class yesVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: ScreenUtil().setWidth(330),
      //height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(45),
          ),
          for (var i = 0; i < sum; i++)
            myVideoLayout(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        videoShowWidget())); //VideoPlayerScreen()));
              },
            ),
          SizedBox(height: ScreenUtil().setHeight(100)),
        ],
      ),
    );
  }
}

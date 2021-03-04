// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/layout/flatbuttonShadow.dart';

int bodyNum = 0;
int natureNum = 0 ;
int exerciseNum = 0;
int socialNum = 0 ;

class galleryVideo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<galleryVideo>{
  
  //영상 개수 가져오기
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CustomElevation(
                  child:FlatButton(onPressed: null,
                  ),
                  text1: "신체",
                  text2: bodyNum.toString()+"개의 영상",
                ),
                SizedBox(width: ScreenUtil().setWidth(15),),
                CustomElevation(child: FlatButton(onPressed: null,),
                    text1: "자연 탐구", text2: natureNum.toString() + "개의 영상",)
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10),),
            Row(
              children: [
                CustomElevation(
                  child:FlatButton(onPressed: null,
                  ),
                  text1: "운동",
                  text2: bodyNum.toString()+"개의 영상",
                ),
                SizedBox(width: ScreenUtil().setWidth(15),),
                CustomElevation(child: FlatButton(onPressed: null,),
                  text1: "사회 관계", text2: natureNum.toString() + "개의 영상",),

              ],
            ),
            noVideo(),
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
          SizedBox(height: ScreenUtil().setHeight(66),),
          Image.asset("assets/images/noVideoGirin.png", width: ScreenUtil().setHeight(132), height: ScreenUtil().setWidth(132),),
          SizedBox(height: ScreenUtil().setHeight(17),),
          Text("아직 촬영한 영상이 없어요", style: TextStyle(fontSize: ScreenUtil().setSp(16), fontFamily: 'Noto Sans KR'),)

        ],
      ),
    );
  }

}


// child: Image.asset(
// 'assets/images/onboard_2.png',
// fit: BoxFit.cover,
// ),

//PostCard() import 하기


// _buildProfile(context),
// SizedBox(height: ScreenUtil().setHeight(41)),
// _buildAccountInfo(context)
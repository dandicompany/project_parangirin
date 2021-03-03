import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/layout/flatbuttonShadow.dart';

class galleryVideo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<galleryVideo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(488),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
        ),
        child: Column(
          children: <Widget>[
            CustomElevation(
                  child:FlatButton(onPressed: null,
                    //child: Text('신체', style: TextStyle(fontSize: 24, color: Colors.black,fontFamily: 'Noto Sans KR',  ), ),
               ),
              text1: "신체",
              text2: "0개의 영상",
             ),

          ],
        ),
      ),
    );
  }
}


// _buildProfile(context),
// SizedBox(height: ScreenUtil().setHeight(41)),
// _buildAccountInfo(context)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

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

          children: [
            Text('galleryVideo'),
            // _buildProfile(context),
            // SizedBox(height: ScreenUtil().setHeight(41)),
            // _buildAccountInfo(context)
          ],
        ),
      ),
    );
  }
}


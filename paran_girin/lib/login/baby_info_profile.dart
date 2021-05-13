import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BabyInfoProfile extends StatefulWidget {
  @override
  _BabyInfoProfileState createState() => _BabyInfoProfileState();
}

class _BabyInfoProfileState extends State<BabyInfoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(347)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DefaultLayout()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(75),
                        height: ScreenUtil().setHeight(75),
                        child: Image.asset("assets/images/thumbnail_pink.png",
                            fit: BoxFit.cover),
                      ),
                      Text(
                        "샐리",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: ScreenUtil().setSp(18),
                            color: AppTheme.colors.base1),
                      ),
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DefaultLayout()));
                  },
                  child: Column(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(75),
                        height: ScreenUtil().setHeight(75),
                        child: Image.asset("assets/images/thumbnail_pink.png",
                            fit: BoxFit.cover),
                      ),
                      Text(
                        "지현",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: ScreenUtil().setSp(18),
                            color: AppTheme.colors.base1),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

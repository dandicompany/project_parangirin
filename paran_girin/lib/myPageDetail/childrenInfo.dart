import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/models/avatar.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout2.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/baby_info_add.dart';


final String chosen = "(으)로 접속중";
final String notchosen = "(으)로 접속하기";

class childrenInfo extends StatefulWidget {
  @override
  _ChildInfoState createState() => _ChildInfoState();
}

class _ChildInfoState extends State<childrenInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding : EdgeInsets.only(bottom: 150),
        child: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child : Column(
            children: [
              BaseAppBar(title : "자녀 관리",),
              SizedBox(height: ScreenUtil().setHeight(30)),
              childrenInfoLayout(
                image: "assets/images/onboard_1.png",
                text: "샐리",
                text2 : chosen,
                press: (){
                },
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              childrenInfoLayout2(
                image : "assets/images/onboard_1.png",
                text: "유진",
                text2 : notchosen,
                press:(){},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //elevation: 4.0,
        shape: _CustomBorder(),
        //icon: const Icon(Icons.add),
        label: const Text('자녀 추가하기'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BabyInfoAdd()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}



class _CustomBorder extends ShapeBorder {
  const _CustomBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    print(rect.left);
    print(rect.top);
    print(rect.right);
    return Path()
      //..moveTo(rect.left-ScreenUtil.defaultSize.width/2+80, rect.top)
      ..moveTo(rect.left, rect.top)
      ..lineTo(rect.right + 115 ,0 )
      ..lineTo(rect.right + 115, 64)
      ..lineTo(rect.left-ScreenUtil.defaultSize.width/2+80, 64)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}


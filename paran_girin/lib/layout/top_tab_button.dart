import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class TopTabButton extends StatelessWidget {
  final String txt;
  final double txtSize;
  final int index;
  final PageController controller;
  final int selectedIndex;

  TopTabButton({
    Key key,
    this.txt,
    this.txtSize = 46, 
    @required this.index,
    @required this.controller,
    this.selectedIndex,
  }) : super(key: key);

  bool get bActive => selectedIndex == index;

  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkResponse(
        onTap: () {
          controller.jumpToPage(index);
        },
        /*
        splashFactory: InkRipple.splashFactory, 
        radius: ScreenUtil().radius(30), 
        containedInkWell: true,
        */
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.6),
          children: [
            Container(
              width: double.infinity / 2,
              height: ScreenUtil().setHeight(97),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: bActive ? AppTheme.colors.primary2 : Color.fromRGBO(170, 170, 170, 1),
                    ), 
                  ),
              ),
            ),
            Container(
              // height: ScreenUtil().setHeight(97),
              child: Text(
                txt,
                style: TextStyle(
                  color: bActive ? AppTheme.colors.base1 : AppTheme.colors.base3,
                  fontSize: ScreenUtil().setSp(14)
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}
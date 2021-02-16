import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class TabButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final int index;
  final PageController controller;
  final int selectedIndex;

  TabButton({
    Key key,
    this.icon,
    this.iconSize = 27.0, //screenutil 적용 가능?
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
        child: Container(
          width: double.infinity / 4,
          height: ScreenUtil().setHeight(84),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 2,
                color: bActive ? AppTheme.colors.primary2 : Color.fromRGBO(170, 170, 170, 1),
                ), 
              ),
          ),
          child: Icon(
            icon,
            size: ScreenUtil().radius(iconSize),
            color: bActive ? Color.fromRGBO(7, 78, 232, 1) : Colors.black, 
          ),
        )
      ),
    );
  }
}
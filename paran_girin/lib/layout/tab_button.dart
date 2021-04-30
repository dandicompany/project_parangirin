import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/theme/app_theme.dart';

class TabButton extends StatelessWidget {
  final String svg;
  final double svgSize;
  final int index;
  final PageController controller;
  final int selectedIndex;

  TabButton({
    Key key,
    this.svg,
    this.svgSize = 24.0, 
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
          alignment: AlignmentDirectional(0.0, -0.3),
          children: [
            Container(
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
            ),
            Container(
              width: ScreenUtil().setWidth(svgSize),
              height: ScreenUtil().setHeight(svgSize),
              child: SvgPicture.asset(
                svg,
                // color: bActive ? AppTheme.colors.primary2 : AppTheme.colors.base1, 
                color: bActive ? Color.fromRGBO(7, 78, 232, 1) : Colors.black, 
                fit: BoxFit.contain
              ),
            ),
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String hashtag;
  final Color color;
  final String icon;
  final Color iconColor;
  final double iconWidth;
  final double iconHeight;

  const CategoryCard({
    Key key, 
    this.onTap, 
    this.title, 
    this.hashtag, 
    this.color, 
    this.icon, 
    this.iconColor, 
    this.iconWidth = 51.0, 
    this.iconHeight = 51.0
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: ScreenUtil().setWidth(343),
          height: ScreenUtil().setHeight(110),
          color: Colors.white,
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            top: ScreenUtil().setHeight(8),
            bottom: ScreenUtil().setHeight(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      // fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base1
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: color,
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(8),
                        right: ScreenUtil().setWidth(15),
                        top: ScreenUtil().setHeight(4),
                        bottom: ScreenUtil().setHeight(5),
                      ),
                      child: Text(
                        hashtag,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          color: AppTheme.colors.base2
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                icon,
                color: iconColor,
                width: ScreenUtil().setWidth(iconWidth),
                height: ScreenUtil().setHeight(iconHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
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

  const CategoryCard({Key key, this.onTap, this.title, this.hashtag, this.color, this.icon}) : super(key: key);

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
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(10),
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
                      fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base1
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: color,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6),
                        vertical: ScreenUtil().setHeight(4),
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
                color: color,
                width: ScreenUtil().setWidth(51),
                height: ScreenUtil().setHeight(51),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
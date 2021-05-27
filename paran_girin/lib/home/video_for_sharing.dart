import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'dart:io';

class VideoForSharing extends StatefulWidget {
  final String title;
  final File thumbnail;
  final String date;
  final String avatar;
  final String background;
  var onSelected;
  var onUnselected;
  bool selected = false;

  VideoForSharing(this.title, this.thumbnail, this.date, this.background,
      this.avatar, this.onSelected, this.onUnselected, this.selected);
  @override
  _VideoForSharingState createState() => _VideoForSharingState();
}

class _VideoForSharingState extends State<VideoForSharing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10),
      ),
      child: GestureDetector(
        child: InkWell(
          onTap: () {
            setState(() {
              widget.selected = !widget.selected;
              if (widget.selected) {
                widget.onSelected();
              } else {
                widget.onUnselected();
              }
            });
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: ScreenUtil().setHeight(261), //261
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(197),
                        child: Row(
                          children: <Widget>[
                            Stack(
                              children: [
                                Image.asset(
                                  widget.background,
                                  width: ScreenUtil().setWidth(145),
                                  height: ScreenUtil().setHeight(197),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                Image.asset(
                                  widget.avatar,
                                  width: ScreenUtil().setWidth(145),
                                  height: ScreenUtil().setHeight(197),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                            Image.file(
                              widget.thumbnail,
                              width: ScreenUtil().setHeight(198),
                              height: ScreenUtil().setHeight(197),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            // Use 'CachedNetworkImage' later
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(64),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(12),
                            vertical: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title, // title
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(16),
                                    fontFamily: 'Noto Sans KR',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(2),
                                ),
                                Text(
                                  widget.date, //date
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                    color: AppTheme.colors.base2,
                                    fontFamily: 'Noto Sans KR',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.selected)
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      height: ScreenUtil().setHeight(261),
                    )),
              if (widget.selected)
                Positioned(
                  bottom: ScreenUtil().setHeight(63),
                  right: ScreenUtil().setWidth(13),
                  child: SvgPicture.asset(
                    "assets/icons/check.svg",
                    width: ScreenUtil().setWidth(21),
                    height: ScreenUtil().setHeight(21),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

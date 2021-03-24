import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/gallery/video_uploader.dart';

class myVideoLayout extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onTapHeart;
  final String title;
  final Image profile;
  final Image avatar;
  final Image thumbnail;
  final String date;
  // final Post post; // post model

  // const PostCard({Key key, this.onTap, this.onTapHeart, this.post}) : super(key: key);
  const myVideoLayout(
      {Key key,
      this.onTap,
      this.onLongPress,
      this.onTapHeart,
      this.title,
      this.profile,
      this.avatar,
      this.thumbnail,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
        vertical: ScreenUtil().setHeight(8), //16
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: InkWell(
            onTap: onTap,
            child: ClipRRect(
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
                          Image.asset(
                            "assets/images/thumbnail_avatar.png",
                            width: ScreenUtil().setHeight(145),
                            height: ScreenUtil().setHeight(197),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          Image.asset(
                            "assets/images/thumbnail_baby.png",
                            width: ScreenUtil().setHeight(198),
                            height: ScreenUtil().setHeight(197),
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
                                "세상에 없던 새로운 대답, 계란", // title
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
                                "2020/01/01", //date
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
                //SizedBox(height: ScreenUtil().setHeight(10),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

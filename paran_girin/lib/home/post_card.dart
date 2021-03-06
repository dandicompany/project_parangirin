import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class PostCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onTapHeart;
  final String title;
  final String description;
  final Image profile;
  final Image avatar;
  final Image thumbnail;
  // final Post post; // post model

  // const PostCard({Key key, this.onTap, this.onTapHeart, this.post}) : super(key: key);
  const PostCard({Key key, this.onTap, this.onTapHeart, this.title, this.description, this.profile, this.avatar, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(16)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: ScreenUtil().setHeight(261),
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
                      horizontal:ScreenUtil().setWidth(12),
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
                                fontSize: ScreenUtil().setSp(16)
                              ),
                            ),
                            Text(
                              "타임캡슐에 담고 싶은 나의 물건은?", // description
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: AppTheme.colors.base2,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/thumbnail_baby.png"),
                          radius: ScreenUtil().setWidth(32),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
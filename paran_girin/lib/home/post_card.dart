import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/home/post_detail.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/gallery/videoStreamWidget.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;
  // final Post post; // post model
  FirebaseProvider fp;
  // const PostCard({Key key, this.onTap, this.onTapHeart, this.post}) : super(key: key);
  PostCard(this.post);
  String background;
  String avatar;
  Child child;
  File profile;
  File thumb;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    StaticInfo info = fp.getStaticInfo();
    child = info.post_children[post.child];
    profile = info.post_profiles[child.profileURL];
    thumb = info.post_thumbnails[basename(post.thumbURL)];
    if ((child != null) && (thumb != null)) {
      background = "assets/background/${child.background}";
      avatar = "assets/avatars/${child.avatar}";
    } else {
      if (child == null){
        logger.d("child null");
      }
      if (profile == null) {
        logger.d("profile null");
      }
      if (thumb == null){
        logger.d("thumnail null");
      }
      return SizedBox.shrink();
    }
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetail(
                    this.post,
                    child.nickName ?? "이름없음",
                    this.background,
                    this.avatar)));
          },
          // onTap: () async {
          // Reference file = fp.getFirestorage().ref(post.videoURL);
          // String url = await file.getDownloadURL();
          // logger.d(url);
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) =>
          //         VideoStreamWidget(url))); //VideoPlayerScreen()));
          // },
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
                        Stack(
                          children: [
                            Image.asset(
                              background,
                              width: ScreenUtil().setWidth(145),
                              height: ScreenUtil().setHeight(197),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            Image.asset(
                              avatar,
                              width: ScreenUtil().setWidth(145),
                              height: ScreenUtil().setHeight(197),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),

                        // Image.asset(
                        //   "assets/images/thumbnail_pink.png",
                        //   width: ScreenUtil().setWidth(145),
                        //   height: ScreenUtil().setHeight(197),
                        //   fit: BoxFit.cover,
                        //   alignment: Alignment.topCenter,
                        // ),
                        Image.file(
                          // "assets/images/thumbnail_baby.png",
                          File(post.thumbURL),
                          width: ScreenUtil().setWidth(198),
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
                              "세상에 없던 새로운 대답, 계란", // title
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16)),
                            ),
                            Text(
                              // "타임캡슐에 담고 싶은 나의 물건은?", // description
                              fp
                                  .getStaticInfo()
                                  .questions[post.qid]
                                  .question,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: AppTheme.colors.base2,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundImage: 
                            (profile != null) ? 
                            FileImage(
                              profile)
                            : AssetImage(
                              "assets/images/thumbnail_baby.png"),
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

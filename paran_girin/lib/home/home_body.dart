import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paran_girin/home/home_avatar_big.dart';
import 'package:paran_girin/home/sharing_my_answers.dart';
import 'package:paran_girin/home/post_card.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/myPageDetail/send_comments.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/utils/FadePageRoute.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class HomeBody extends StatefulWidget {
  _HomeBody createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  FirebaseProvider fp;
  String getWeek(DateTime d) {
    int day = d.day;
    int weekday = d.weekday;
    if (weekday == 6) {
      String ym = "${d.year}년 ${d.month}월";
      switch (((day + 6) / 7).floor()) {
        case 1:
          return ym + " 첫째 주";
          break;
        case 2:
          return ym + " 둘째 주";
          break;
        case 3:
          return ym + " 셋째 주";
          break;
        case 4:
          return ym + " 넷째 주";
          break;
        case 5:
          return ym + " 다섯째 주";
        default:
          return "동동주";
      }
    }
    DateTime this_sat = d.add(Duration(days: 6 - (weekday % 7)));
    return getWeek(this_sat);
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    List<Post> posts = fp.getStaticInfo().posts;
    logger.d("num of posts: ${posts.length}");
    return ListView.separated(
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(children: <Widget>[
              HomeAvatar(),
              SizedBox(height: ScreenUtil().setHeight(28)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "생각 뽐내기",
                      style: TextStyle(
                          color: AppTheme.colors.base1,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                    Text(
                      getWeek(DateTime.now()),
                      style: TextStyle(
                          color: AppTheme.colors.base2,
                          fontSize: ScreenUtil().setSp(12)),
                    )
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(24)),
            ]);
          }
          if (index >= posts.length + 1) {
            return Column(children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(16)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16)),
                child: DefaultButton(
                  text: "우리 아이 뽐내기",
                  isInvert: true,
                  press: () {
                    Navigator.of(context).push(
                        FadePageRoute(widget: SharingMyAnswers()));
                  },
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(48)),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "의견 보내기",
                          style: TextStyle(
                              color: AppTheme.colors.base1,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(18)),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(23)),
                        DefaultButton(
                          text: "생각을 공유해주세요!",
                          isInvert: true,
                          press: () {
                            Navigator.of(context).push(
                                FadePageRoute(widget: SendComments()));
                          },
                        ),
                        SizedBox(height: ScreenUtil().setHeight(14)),
                        Center(
                          child: Text(
                            "재미있는 아이디어, 소중한 질문, 불만족스러운 의견 등\n파란기린이 발전할 수 있도록 다양한 의견을 공유해주세요!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.colors.base3,
                                fontSize: ScreenUtil().setSp(12),
                                height: 1.4),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(120))
                      ]))
            ]);
          }
          Post post = Post.fromJson(posts[index - 1].toJson());
          File file = fp.getStaticInfo().post_thumbnails[post.thumbURL];
          try {
            if (file != null) {
              post.thumbURL = file.path;
              logger.d("post loaded");
              return PostCard(post);
            } else {
              logger.d("post unloaded");
              logger.d(post);
              logger.d(index);
              return SizedBox.shrink();
            }
          } catch (e) {
            print(e);
          }
        },
        separatorBuilder: (context, index) {
          return (index == 0)
              ? SizedBox.shrink()
              : SizedBox(height: ScreenUtil().setHeight(8));
        },
        itemCount: posts.length + 2);
  }
    // child: StreamBuilder(
    //     stream: fp.getFirestore().collection('posts').snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState ==
    //           ConnectionState.active) {
    //         List<QueryDocumentSnapshot> posts =
    //             snapshot.data.docs;
    //         return ListView.separated(
    //             // physics: const NeverScrollableScrollPhysics(),
    //             itemBuilder: (context, index) {
    //               return FutureBuilder(
    //                 future: () async {
    //                   Post post =
    //                       Post.fromJson(posts[index].data());
    //                   // post.thumbURL = fp
    //                   //     .getStaticInfo()
    //                   //     .post_thumbnails[post.videoURL];
    //                   // post.thumbURL =
    //                   //     "assets/images/thumbnail_baby.png";
    //                   // logger.d(post.thumbURL);

    //                   // assert(post.thumbURL != null);
    //                   Reference ref =
    //                       fp.getFirestorage().ref(post.thumbURL);
    //                   // String url = await file.getDownloadURL();
    //                   post.thumbURL = join(
    //                       (await getTemporaryDirectory()).path,
    //                       post.thumbURL);
    //                   File thumbnail = File(post.thumbURL);

    //                   final task =
    //                       await ref.writeToFile(thumbnail);
    //                   // // post.videoURL = url;
    //                   // try {
    //                   //   logger.d(url);
    //                   //   final thumb =
    //                   //       await VideoThumbnail.thumbnailFile(
    //                   //     video: url,
    //                   //     thumbnailPath: post.thumbURL,
    //                   //     timeMs: 5,
    //                   //     imageFormat: ImageFormat.PNG,
    //                   //     maxHeight:
    //                   //         68, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    //                   //     quality: 75,
    //                   //   );
    //                   //   post.thumbURL = thumb;
    //                   // } catch (e) {
    //                   //   logger.d(e);
    //                   // }

    //                   // // answer.thumbnail = thumb.pat
    //                   // logger.d("thumbnail extracted");
    //                   return post;
    //                 }(),
    //                 builder: (context, snapshot) {
    //                   if (snapshot.connectionState ==
    //                       ConnectionState.done) {
    //                     return PostCard(snapshot.data);
    //                   } else {
    //                     return SizedBox.shrink();
    //                   }
    //                 },
    //               );
    //             },
    //             separatorBuilder: (context, index) {
    //               return SizedBox(
    //                   height: ScreenUtil().setHeight(8));
    //             },
    //             itemCount: posts.length);
    //       } else {
    //         return SizedBox.shrink();
    //       }
    //     }),
}

class HomeAvatar extends StatelessWidget {
  const HomeAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(FadePageRoute(widget: HomeAvatarBig()));
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(488),
              child: Image.asset(
                "assets/background/home_background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(children: [
              SizedBox(
                width: ScreenUtil().setWidth(426),
                height: ScreenUtil().setHeight(44),
              ),
              Container(
                width: ScreenUtil().setWidth(426),
                height: ScreenUtil().setHeight(426),
                child: Image.asset(
                  'assets/avatars/nod.gif',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

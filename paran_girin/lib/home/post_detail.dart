import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/gallery/videoShowWidget.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/layout/default_icon_botton.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/gallery/videoStreamWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class PostDetail extends StatefulWidget {
  final Post post;
  final String name;
  final String background;
  final String avatar;
  // final Post post; // post model

  // const PostCard({Key key, this.onTap, this.onTapHeart, this.post}) : super(key: key);
  PostDetail(this.post, this.name, this.background, this.avatar);

  State<StatefulWidget> createState() =>
      _PostDetail(post, name, background, avatar);
}

class _PostDetail extends State<PostDetail> {
  final Post post;
  final String name;
  final String background;
  final String avatar;
  FirebaseProvider fp;
  bool playingVideo = false;
  final contents =
      '''관련된 텍스트 예를 들어 이 질문의 목적이 어떻고이 질문에 대답하면 뭐가 좋아지고 아이에게는 뭐가 어떻고 선정된 이 아이는 이 질문에 대해서 어떻게 신박하게 대답했는지 그리고

  거기에 대한 짧은 의견 또는 칭찬 등등 우리의 의견 사실 텍스트 채우는 게 예쁠 것 같아서 주절주절 쓰는 중인더 짧거나 생략되는 방안도 있을 것 같아오 주절주절 분량 채우는 더미 텍스트''';

  _PostDetail(this.post, this.name, this.background, this.avatar);
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
    DateTime thisSat = d.add(Duration(days: 6 - (weekday % 7)));
    return getWeek(thisSat);
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    // Post model에 Question 정보 없어도 되나?
    // Child.answers를 이용해서 이 질문에 대답했는지 안했는지 판단하기
    bool questionDone = fp.getStaticInfo().answers.containsKey(post.qid);
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(331),
                  child: playingVideo
                      ? ChewieListItem(
                          // videoPlayerController: VideoPlayerController.file(file),
                          videoPlayerController:
                              VideoPlayerController.network(post.videoURL),
                          looping: true,
                        )
                      : Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              // child: Image.asset(
                              //   // "assets/images/thumbnail_pink.png",
                              //   background,
                              //   // width: ScreenUtil().setWidth(187),
                              //   // height: ScreenUtil().setHeight(331),
                              //   fit: BoxFit.cover,
                              //   alignment: Alignment.topCenter,
                              // ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    background,
                                    width: ScreenUtil().setWidth(187),
                                    height: ScreenUtil().setHeight(331),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  Image.asset(
                                    avatar,
                                    width: ScreenUtil().setWidth(187),
                                    height: ScreenUtil().setHeight(331),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                // child: Image.asset("assets/images/thumbnail_baby.png",
                                //     width: ScreenUtil().setWidth(187),
                                //     height: ScreenUtil().setHeight(331),
                                //     fit: BoxFit.cover),
                                child: Image.file(File(post.thumbURL),
                                    width: ScreenUtil().setWidth(187),
                                    height: ScreenUtil().setHeight(331),
                                    fit: BoxFit.cover)),
                            // Use 'CachedNetworkImage' later
                          ],
                        ),
                ),
                playingVideo
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () async {
                          Reference file =
                              fp.getFirestorage().ref(post.videoURL);
                          String url = await file.getDownloadURL();
                          post.videoURL = url;
                          // String url = 'https://youtu.be/wgbr7exUnzE';
                          logger.d(url);
                          setState(() {
                            playingVideo = true;
                          });
                        },
                        child: Container(
                            child: Image.asset(
                          "assets/icons/play_button.png",
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setHeight(60),
                        )))
              ],
            ),
            Positioned(
              bottom: ScreenUtil().setHeight(13),
              left: ScreenUtil().setWidth(17),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (fp.getStaticInfo().profile == null)
                        ? AssetImage("assets/images/thumbnail_baby.png")
                        : FileImage(fp.getStaticInfo().profile),
                    // FileImage(fp.getStaticInfo().profile),
                    radius: ScreenUtil().setWidth(16),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(8)),
                  Text(name,
                      // baby_nickname,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w300,
                          color: AppTheme.colors.base2)),
                ],
              ),
            ),
            Positioned(
                bottom: ScreenUtil().setHeight(21),
                right: ScreenUtil().setWidth(15),
                child: Text(
                    getWeek(DateTime.fromMillisecondsSinceEpoch(post.date)),
                    // week,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w300,
                        color: Colors.white))),
            Positioned(
              top: ScreenUtil().setHeight(44),
              left: ScreenUtil().setWidth(16),
              child: Navigator.of(context).canPop()
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.colors.base1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: ScreenUtil().radius(20),
                    )
                  : null,
            )
          ]),
          SizedBox(height: ScreenUtil().setHeight(28)),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16.0)),
            child: Stack(
              children: [
                Container(
                  height: ScreenUtil().setHeight(450),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("세상에 없던 새로운 대답, 계란",
                          // title,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                          )),
                      SizedBox(height: ScreenUtil().setHeight(36)),
                      Text(
                        // fp.getFirestorage().str(post.videoURL),
                        // "타임캡슐에 담고 싶은 나의 물건은?",
                        fp.getStaticInfo().questions[post.qid].question,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,
                            color: AppTheme.colors.primary2),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      Text(
                        // contents,
                        post.comment ?? contents,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            color: AppTheme.colors.base2,
                            height: 1.7),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: questionDone
                      ? ScreenUtil().setHeight(58)
                      : ScreenUtil().setHeight(50),
                  child: questionDone
                      ? Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  Answer answer =
                                      fp.getStaticInfo().answers[post.qid];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VideoShowWidget(
                                          post.qid,
                                          answer))); //VideoPlayerScreen()));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => VideoShowWidget()));
                                },
                                child: Text(
                                  "대답한 영상 보기",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: AppTheme.colors.base2,
                                      decoration: TextDecoration.underline),
                                )),
                            SizedBox(height: ScreenUtil().setHeight(8)),
                            DefaultButton(
                                text: "이미 대답한 질문이에요",
                                color: AppTheme.colors.base2,
                                isInvert: false,
                                press: () {}),
                          ],
                        )
                      : DefaultIconButton(
                          text: "이 질문으로 대화하기",
                          icon: "assets/icons/camera.svg",
                          isInvert: false,
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Initialization(post.qid)));
                          }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

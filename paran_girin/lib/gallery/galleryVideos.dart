// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/gallery/myVideoLayout.dart';
import 'package:paran_girin/gallery/videoShowWidget.dart';
import 'package:paran_girin/layout/default_icon_botton.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/layout/flatbuttonShadow.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:paran_girin/home/home_avatar_big.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paran_girin/layout/splash.dart';
import 'dart:io';

int bodyNum = 0;
int natureNum = 0;
int artNum = 0;
int socialNum = 0;
int commuNum = 0;
int sum = bodyNum + natureNum + artNum + socialNum;

class GalleryVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<GalleryVideo> {
  bool buttonClickedState = true;
  bool buttonClickedState2 = true;
  bool buttonClickedState3 = true;
  bool buttonClickedState4 = true;
  FirebaseProvider fp;
  //영상 개수 가져오기
  @override
  void initState() {
    super.initState();
    sum = 3;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fp = Provider.of<FirebaseProvider>(context);
    artNum = 0;
    bodyNum = 0;
    natureNum = 0;
    socialNum = 0;
    commuNum = 0;
    for (var key in fp.getUserInfo().currentChild.answers.keys) {
      Question q = fp.getStaticInfo().questions[key];
      switch (q.category) {
        case "예술":
          artNum += 1;
          break;
        case "신체":
          bodyNum += 1;
          break;
        case "자연탐구":
          natureNum += 1;
          break;
        case "의사소통":
          socialNum += 1;
          break;
        case "사회관계":
          commuNum += 1;
          break;
        default:
      }
    }
    sum = bodyNum + natureNum + artNum + socialNum + artNum;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(132),
              ),
              Row(
                children: [
                  CustomElevation(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonClickedState = !buttonClickedState;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: ScreenUtil().setWidth(164),
                      height: ScreenUtil().setHeight(71),
                    ),
                    text1: "신체",
                    text2: bodyNum.toString() + "개의 영상",
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  CustomElevation(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonClickedState2 = !buttonClickedState2;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: ScreenUtil().setWidth(164),
                      height: ScreenUtil().setHeight(71),
                    ),
                    text1: "자연 탐구",
                    text2: natureNum.toString() + "개의 영상",
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Row(
                children: [
                  CustomElevation(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonClickedState3 = !buttonClickedState3;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: ScreenUtil().setWidth(164),
                      height: ScreenUtil().setHeight(71),
                    ),
                    text1: "예술",
                    text2: artNum.toString() + "개의 영상",
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(15),
                  ),
                  CustomElevation(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          buttonClickedState3 = !buttonClickedState3;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: ScreenUtil().setWidth(164),
                      height: ScreenUtil().setHeight(71),
                    ),
                    text1: "사회 관계",
                    text2: socialNum.toString() + "개의 영상",
                  ),
                ],
              ),
              sum == 0 ? NoVideo() : YesVideo(),
            ],
          ),
        ),
      ),
    );
  }
}

class NoVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(66),
          ),
          Image.asset(
            "assets/images/noVideoGirin.png",
            width: ScreenUtil().setHeight(132),
            height: ScreenUtil().setWidth(132),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(17),
          ),
          Text(
            "아직 촬영한 영상이 없어요",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                color: AppTheme.colors.base2,
                fontFamily: 'Noto Sans KR'),
          ),
          SizedBox(height: ScreenUtil().setHeight(80)),
          DefaultIconButton(
              text: "파란 기린과 대화하기 ",
              isInvert: false,
              press: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeAvatarBig()));
              })
        ],
      ),
    );
  }
}

class YesVideo extends StatelessWidget {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    Map<String, Answer> answers = fp.getStaticInfo().answers;
    List<MapEntry<String, Answer>> entries = List<MapEntry<String, Answer>>();
    for (var entry in answers.entries) {
      entries.add(entry);
    }
    entries.sort((a, b) => a.value.date.compareTo(b.value.date));
    answers = Map.fromEntries(entries);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(45),
        ),
        // for (var i = 0; i < sum; i++)
        for (var key in answers.keys)
          FutureBuilder(
            future: () async {
              logger.d("loading answers...");
              Answer answer = answers[key];
              if (answer == null) {
                return null;
              }
              logger.d("answers loaded");
              String thumbURL = (await getTemporaryDirectory()).path;
              // answer.thumbnail = null;
              // (await getApplicationDocumentsDirectory()).path;
              // logger.d("path identified: " + answer.thumbnail);
              try {
                logger.d(answer.videoURL);
                final thumb = await VideoThumbnail.thumbnailFile(
                  video: answer.videoURL,
                  thumbnailPath: thumbURL,
                  imageFormat: ImageFormat.PNG,
                  maxHeight:
                      100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
                  quality: 100,
                );
                logger.d(thumb);
                answer.thumbnail = File(thumb);
              } catch (e) {
                logger.d(e);
              }

              // answer.thumbnail = thumb.pat
              logger.d("thumbnail extracted");
              return answer;
            }(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                logger.d(snapshot.data);
                Answer answer = snapshot.data;
                if (answer == null) {
                  return SizedBox.shrink();
                }
                return MyVideoLayout(
                  title: fp.getStaticInfo().questions[key].title,
                  date: DateTime.fromMillisecondsSinceEpoch(answer.date)
                      .toString(),
                  thumbnail: answer.thumbnail,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoShowWidget(
                            key, answer))); //VideoPlayerScreen()));
                  },
                  onLongPress: () async {
                    String path = await fp
                        .getUploadManager()
                        .uploadVideo(answer.videoURL);
                    // String thumbnail = await fp.getUploadManager().upload
                    String thumbURL = await fp
                        .getUploadManager()
                        .uploadImage(answer.thumbnail);
                    fp.addPost(key, path, thumbURL, null);
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        SizedBox(height: ScreenUtil().setHeight(100)),
      ],
    );
  }
}

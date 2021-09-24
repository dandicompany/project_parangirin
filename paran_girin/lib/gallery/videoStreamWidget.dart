import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

var file = File("assets/videoEx/sample1.mp4");
// "/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4");
var path = 'assets/videoEx/sample1.mp4';

class VideoStreamWidget extends StatelessWidget {
  FirebaseProvider fp;
  String url = "/assets/videoEx/sample1.mp4";
  Post post;
  String qid;
  Question question;
  VideoStreamWidget(this.post);
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    qid = post.qid;
    logger.d("post videoURL: ${post.videoURL}");
    Reference file =
        fp.getFirestorage().ref(post.videoURL);
    url = await file.getDownloadURL();
    logger.d("post video download URL: $url");
    question = fp.getStaticInfo().questions[qid];
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(28),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    // '계란을 우주로 보낸다면?',
                    question.title,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: AppTheme.colors.base1),
                  ),
                ],
              ),
              Text(DateTime.fromMillisecondsSinceEpoch(post.date).toString(),
                  style: new TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: AppTheme.colors.base3)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(question.tag,
                  style: new TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: AppTheme.colors.primary2)),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(17),
            ),
            child: Container(
              height: ScreenUtil().setHeight(600),
              child: ChewieListItem(
                // videoPlayerController: VideoPlayerController.file(file),
                videoPlayerController: VideoPlayerController.network(url),
                looping: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:paran_girin/home/home_avatar_big.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/home/home_avatar_big.dart';

var file = File("assets/videoEx/sample1.mp4");
// "/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4");
var path = 'assets/videoEx/sample1.mp4';
DateFormat dateFormat = DateFormat("yyyy년 MM월 dd일");

class VideoShowFromCamera extends StatelessWidget {
  FirebaseProvider fp;
  String url = "/assets/videoEx/sample1.mp4";
  File file;
  String qid;
  Answer answer;
  Question question;
  VideoShowFromCamera(this.qid, this.answer);
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    file = File(answer.videoURL);
    logger.d(file.path);
    question = fp.getStaticInfo().questions[qid];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(40),
              left: ScreenUtil().setWidth(16),
            ),
            child: Positioned(
              top: ScreenUtil().setHeight(44),
              left: ScreenUtil().setWidth(16),
              child: Navigator.of(context).canPop()
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.colors.base1,
                      ),
                      onPressed: () {
                        // Navigator.pushReplacement<void, void>(
                        //     context,MaterialPageRoute<void>(
                        //       builder: (BuildContext context) => HomeAvatar()VideoShowFromCamera(question, fp.getStaticInfo().answers[question])));
                      


                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => HomeAvatarBig()));
                        // Navigator.popUntil(context, ModalRoute.withName('/'));
                        Navigator.of(context).pop(); 
                      },
                      iconSize: ScreenUtil().radius(20),
                    )
                  : null,
            )
          ),
          Padding(
            padding: EdgeInsets.only(
              // top: ScreenUtil().setHeight(50),
              left: ScreenUtil().setWidth(28),
              right: ScreenUtil().setWidth(28)
            ),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // '계란을 우주로 보낸다면?',
                        question.title,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: AppTheme.colors.base1),
                      ),
                      InkWell(
                          onTap: () {
                          },
                          child: SvgPicture.asset(
                            "assets/icons/more-horizontal.svg",
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setHeight(24),
                          )
                        ),
                    ],
                  ),
                  Text(
                    // DateTime.fromMillisecondsSinceEpoch(answer.date).toString(),
                    dateFormat.format(DateTime.fromMillisecondsSinceEpoch(answer.date)),
                    style: new TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: AppTheme.colors.base3
                    )
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(question.tag,
                      style: new TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: AppTheme.colors.primary2
                      )
                  ),
                ] 
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(17),
              ),
              child: Container(
                // height: ScreenUtil().setHeight(600),
                height: ScreenUtil().setHeight(570),
                child: ChewieListItem(
                  // videoPlayerController: VideoPlayerController.file(file),
                  videoPlayerController: VideoPlayerController.file(file),
                  looping: false,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
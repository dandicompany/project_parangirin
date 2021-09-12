import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

var file = File("assets/videoEx/sample1.mp4");
// "/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4");
var path = 'assets/videoEx/sample1.mp4';
DateFormat dateFormat = DateFormat("yyyy년 MM월 dd일");

class VideoShowWidget extends StatefulWidget {
  Question question;
  Answer answer;

  VideoShowWidget({Key key, this.question, this.answer}) : super(key: key);

  @override
  _VideoShowWidgetState createState() => _VideoShowWidgetState();
}

class _VideoShowWidgetState extends State<VideoShowWidget> {
  FirebaseProvider fp;
  String url = "/assets/videoEx/sample1.mp4";
  File file;
  String qid;
  List<String> filePath = [];
  // VideoShowWidget(this.qid, this.answer);

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    file = File(widget.answer.videoURL);
    logger.d(file.path);
    filePath.add(file.path);
    widget.question = fp.getStaticInfo().questions[qid];
    bool _popVisible = false;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(44),
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(28),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Navigator.of(context).canPop()
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            _popVisible = !_popVisible;
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/icons/more-horizontal.svg",
                          width: ScreenUtil().setWidth(24),
                          height: ScreenUtil().setHeight(24),
                        )
                      ),
                    ]
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
                        Text(
                          widget.question.title,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: AppTheme.colors.base1),
                        ),
                        Text(
                          dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.answer.date)),
                          style: new TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: AppTheme.colors.base3
                          )
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(widget.question.tag.split("#").join(" #").substring(1),
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
          ),
        ],
      ),
    );
  }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    if (filePath.isNotEmpty) {
      await Share.shareFiles(filePath,
          text: "${fp.getUserInfo().currentChild.nickName}이가 파란기린의 ${widget.question.title} 질문에 대해 이렇게 대답했어요.\n파란기린 앱 링크",
          subject: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.answer.date)),
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      // await Share.share(
      //     text,
      //     subject: subject,
      //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}

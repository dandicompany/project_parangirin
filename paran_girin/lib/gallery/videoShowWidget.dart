import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

var file = File(
  "assets/videoEx/sample1.mp4");
    // "/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4");
var path = 'assets/videoEx/sample1.mp4';

class VideoShowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child:  Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(70),
              left: ScreenUtil().setWidth(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '계란을 우주로 보낸다면?',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: AppTheme.colors.base1
                      ),
                    ),
                  ],
                ),
                Text(
                  '2020년 09월 10일',
                  style: new TextStyle(
                    fontSize: ScreenUtil().setSp(12),
                    color: AppTheme.colors.base3
                  )
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  '#공감각 훈련 #상상력 #시각화',
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
              height: ScreenUtil().setHeight(600),
              child: ChewieListItem(
                // videoPlayerController: VideoPlayerController.file(file),
                videoPlayerController: VideoPlayerController.asset(path),
                looping: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  
    
}

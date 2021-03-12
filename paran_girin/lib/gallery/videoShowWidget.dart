import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class videoShowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(40),
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
      ),
      child: Container(
          child : ChewieListItem(
              videoPlayerController: VideoPlayerController.asset('assets/videoEx/videoTest.mp4'),
              looping: true,
              ),
        ),
      );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/gallery/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

var file = File(
    "/data/user/0/com.example.paran_girin/app_flutter/2021-03-14 22:23:56.187923.mp4");

class videoShowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(40),
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16),
      ),
      child: Container(
        child: ChewieListItem(
          videoPlayerController: VideoPlayerController.file(file),
          looping: true,
        ),
      ),
    );
  }
}
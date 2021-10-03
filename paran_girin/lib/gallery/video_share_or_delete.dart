import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/gallery/pop_button.dart';
import 'package:paran_girin/theme/app_theme.dart';

class VideoShareOrDelete extends StatefulWidget {
  var share;
  var delete;

  VideoShareOrDelete({Key key, this.share, this.delete}) : super(key: key);
  @override
  _VideoShareOrDeleteState createState() => _VideoShareOrDeleteState();
}

class _VideoShareOrDeleteState extends State<VideoShareOrDelete> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
      insetPadding: EdgeInsets.only(
        left: (MediaQuery.of(context).size.width- ScreenUtil().setWidth(360))/2,
        right: (MediaQuery.of(context).size.width- ScreenUtil().setWidth(360))/2,
      ),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: ScreenUtil().setHeight(38),
          // left: (MediaQuery.of(context).size.width- ScreenUtil().setWidth(360))/2,
          child: Container(
            width: ScreenUtil().setWidth(360),
            height: ScreenUtil().setWidth(180),
            child: Column(
              children: [
                PopButton(
                  title: "공유하기",
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                  onTap: widget.share,
                  opacity: 0.85
                ),
                Divider(
                  height: 1.0,
                  indent: ScreenUtil().setWidth(8),
                  endIndent: ScreenUtil().setWidth(8),
                ),
                PopButton(
                  title: "삭제",
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  ),
                  onTap: widget.delete, // add delete
                  textColor: Colors.red,
                  opacity: 0.85
                ),
                SizedBox(height: ScreenUtil().setHeight(8)),
                PopButton(
                  title: "닫기",
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  opacity: 1
                )
              ]
            ),
          )
        )
      ],
    );
  }
}

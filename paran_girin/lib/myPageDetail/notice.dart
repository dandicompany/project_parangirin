import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  bool _noticeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: '공지사항',),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(32)
          ),
          NoticeElem(
            noticeTitle: "게시글 제목",
            noticeDate: "2021-03-13",
            noticeText: "파란기린 공지글 안녕하세요 여러분 저희는 단디 테크팀입니다. 중요한 전달 사항이 있어요. 단디 팀 너무 좋다는 거에요. 너무 당연하다고요? 그래도 한 번 말해봤어요. 다들 파이팅 >>!",
          ),
        ],
      ),
    );
  }
}

class NoticeElem extends StatefulWidget {
  final String noticeTitle;
  final String noticeDate;
  final String noticeText;

  const NoticeElem({Key key, this.noticeTitle, this.noticeDate, this.noticeText}) : super(key: key);

  @override
  _NoticeElemState createState() => _NoticeElemState();
}

class _NoticeElemState extends State<NoticeElem> {
  bool _noticeVisible = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(16)
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                _noticeVisible = !_noticeVisible;
              });
            },
            child: Container(
              height: ScreenUtil().setHeight(48),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(width: ScreenUtil().setWidth(23),),
                        Text(
                          widget.noticeTitle,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.noticeDate,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10)
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(12),),
                        SvgPicture.asset(
                          _noticeVisible ? "assets/icons/arrow-up.svg" : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(20),
                          color: AppTheme.colors.base3,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(11),),
                      ],
                    ),
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10),
                horizontal: ScreenUtil().setWidth(16)),
            color: Colors.white,
            child: Visibility(
              visible: _noticeVisible,
              child: Text(
                widget.noticeText,
                style: TextStyle(
                    color: AppTheme.colors.base1,
                    fontSize: ScreenUtil().setSp(14)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_url/open_url.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  bool _noticeVisible = false;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: '공지사항',
      ),
      body: Column(
        children: [
          SizedBox(width: double.infinity, height: ScreenUtil().setHeight(32)),
          SizedBox(
              height: ScreenUtil().setHeight(630),
              child: FutureBuilder(
                  future: fp.getFirestore().collection("notices").get(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      List<QueryDocumentSnapshot> notices = snap.data.docs;
                      List<NoticeItem> noticeItems = List<NoticeItem>();
                      notices.forEach((element) {
                        noticeItems.add(NoticeItem.fromJson(element.data()));
                      });
                      noticeItems.sort((a, b) => a.date.compareTo(b.date));
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            NoticeItem notice = noticeItems[index];
                            return notice.hasURL 
                              ? NoticeElemWithURL(
                                noticeTitle: notice.title,
                                noticeDate: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(notice.date)),
                                )
                              : NoticeElem(
                                noticeTitle: notice.title,
                                noticeDate: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(notice.date)),
                                noticeText: notice.content.replaceAll("\\n", "\n")
                              );
                          },
                          itemCount: notices.length);
                    } else {
                      return SizedBox.shrink();
                    }
                  }))
        ],
      ),
    );
  }
}

class NoticeElem extends StatefulWidget {
  final String noticeTitle;
  final String noticeDate;
  final String noticeText;

  const NoticeElem(
      {Key key, this.noticeTitle, this.noticeDate, this.noticeText})
      : super(key: key);

  @override
  _NoticeElemState createState() => _NoticeElemState();
}

class _NoticeElemState extends State<NoticeElem> {
  bool _noticeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
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
                        SizedBox(
                          width: ScreenUtil().setWidth(23),
                        ),
                        Text(
                          widget.noticeTitle,
                          style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: _noticeVisible 
                                        ? FontWeight.w500 
                                        : FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.noticeDate,
                          style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(10),
                            // fontWeight: FontWeight.w300
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(12),
                        ),
                        SvgPicture.asset(
                          _noticeVisible
                              ? "assets/icons/arrow-up.svg"
                              : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(20),
                          color: AppTheme.colors.base3,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(11),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Visibility(
            visible: _noticeVisible,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(23)),
                color: Colors.white,
                child: Text(
                    widget.noticeText,
                    style: TextStyle(
                      color: AppTheme.colors.base1,
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.w300
                    ),
                  )
              ),
          ),
          Divider(
            color: AppTheme.colors.background,
            height: 2,
          ),
        ],
      ),
    );
  }
}

class NoticeElemWithURL extends StatefulWidget {
  final String noticeTitle;
  final String noticeDate;

  const NoticeElemWithURL(
      {Key key, this.noticeTitle, this.noticeDate})
      : super(key: key);

  @override
  _NoticeElemWithURLState createState() => _NoticeElemWithURLState();
}

class _NoticeElemWithURLState extends State<NoticeElemWithURL> {
  bool _noticeVisible = false;

  @override
  Widget build(BuildContext context) {
    logger.d("notice with url: ${widget.noticeTitle}");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
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
                        SizedBox(
                          width: ScreenUtil().setWidth(23),
                        ),
                        Text(
                          widget.noticeTitle,
                          style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: _noticeVisible 
                                        ? FontWeight.w500 
                                        : FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.noticeDate,
                          style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(10),
                            // fontWeight: FontWeight.w300
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(12),
                        ),
                        SvgPicture.asset(
                          _noticeVisible
                              ? "assets/icons/arrow-up.svg"
                              : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(20),
                          color: AppTheme.colors.base3,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(11),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Visibility(
            visible: _noticeVisible,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(23)),
                color: Colors.white,
                child:  Column(
                  children: [
                    Text(
                      '안녕하세요, 파란기린입니다.\n파란기린은 현재 parangirin_official 인스타그램 계정을 운영하고 있습니다.\n바로가기 : ',
                      style: TextStyle(
                        color: AppTheme.colors.base1,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                          logger.d('start to launch url');
                        // final result = await openUrl('https://github.com/renatoathaydes/open_url');
                        // if (result.exitCode == 0) {
                        //   logger.d('URL should be open in your browser');
                        // } else {
                        //   logger.d('Something went wrong (exit code = ${result.exitCode}): '
                        //       '${result.stderr}');
                        // }
                        
                        var url = 'https://www.instagram.com/parangirin_official/';
                        if (await canLaunch(url)) {
                          await launch(url, forceSafariVC: false, forceWebView: false);
                          logger.d('launch url');
                        } else {
                          logger.d("Could not launch $url");
                        }
                        logger.d('hey');

                      },
                      child: Text(
                        'https://www.instagram.com/parangirin_official/',
                        style: TextStyle(
                          color: AppTheme.colors.primary1,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(12),
                          decoration: TextDecoration.underline
                        ),
                      )
                    ),
                    Text(
                      '\n\n인스타그램으로 파란기린 소식과 아이들의 순수한 답변을 확인해보세요!\n영상을 생각뽐내기에 신청하시면, 어플 뿐만 아니라 인스타그램에도 게시될 수 있어요.\n\n파란기린 드림',
                      style: TextStyle(
                        color: AppTheme.colors.base1,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                  ],
                )
              ),
          ),
          Divider(
            color: AppTheme.colors.background,
            height: 2,
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:intl/intl.dart';

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
                            return NoticeElem(
                                noticeTitle: notice.title,
                                noticeDate: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(notice.date)),
                                noticeText: notice.content.replaceAll("\\n", "\n"));
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

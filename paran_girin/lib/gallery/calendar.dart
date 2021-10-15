import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/gallery/videoShowWidget.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';
import 'package:paran_girin/layout/splash.dart';
import 'package:paran_girin/gallery/videoStreamWidget.dart';

int num = 0;

class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  FirebaseProvider fp;
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  //List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  int meetings = 0;
  Map<String, Answer> _answers = Map<String, Answer>();

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};

    // prefsData();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    initializeDateFormatting();
    var answers = fp.getUserInfo().currentChild.answers;
    logger.d("built");
    logger.d(answers);
    _answers = fp.getStaticInfo().answers;
    meetings = 0;
    for (var key in _answers.keys) {
      Answer ans = _answers[key];
      if (ans == null) {
        return null;
      }
      DateTime date = DateTime.fromMillisecondsSinceEpoch(ans.date);
      _events[date] = [key];
      if (date.month == DateTime.now().month) {
        logger.d(key);
        logger.d(meetings);
        meetings += 1;
      }
    }
    logger.d("finished");
    // _events[DateTime(2021, 06, 04)] = ["a"];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(164)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(28)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "안녕, " + fp.getUserInfo().currentChild.nickName + "!",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(11),
                ),
                Text(
                  "이번 달에 파란기린과 " + meetings.toString() + "번 만났어요",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
              ]
            )
          ),
          SizedBox(
            height: ScreenUtil().setHeight(27),
          ),
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(16),
              ),
              Container(
                width: ScreenUtil().setWidth(343),
                height: ScreenUtil().setHeight(329),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TableCalendar(
                        events: _events,
                        calendarController: _calendarController,
                        locale: 'ko-KR',
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                          todayColor: null,
                          renderSelectedFirst: false,
                          todayStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(20),
                              color: Colors.black),
                          selectedColor: Colors.white,
                          selectedStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: AppTheme.colors.base3),
                          outsideDaysVisible: false,
                          weekdayStyle: TextStyle(
                              color: AppTheme.colors.base3,
                              fontSize: ScreenUtil().setSp(20)),
                          weekendStyle: TextStyle(
                              color: AppTheme.colors.base3,
                              fontSize: ScreenUtil().setSp(20)),
                          holidayStyle: TextStyle(
                              color: AppTheme.colors.base3,
                              fontSize: ScreenUtil().setSp(20)),
                          eventDayStyle: TextStyle(
                              color: AppTheme.colors.base3,
                              fontSize: ScreenUtil().setSp(20)),
                          markersColor: AppTheme.colors.primary3,
                          markersPositionBottom: ScreenUtil().setHeight(3.0),
                          markersMaxAmount: 1,
                        ),

                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          //leftChevronMargin: EdgeInsets.only(10/0),
                        ),
                        startingDayOfWeek: StartingDayOfWeek.sunday,

                        onDaySelected: (date, events, holidays) {
                          // setState(() {
                          logger.d(_calendarController.selectedDay);
                          if (events.length == 1) {
                            logger.d("selected");
                            print(_calendarController.selectedDay.toString());
                            Answer answer = _answers[events[0]];
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoShowWidget(
                                    qid: events[0],
                                    answer: answer))); 
                                    //VideoPlayerScreen()));
                          }
                          // });
                        }, // onDaySelected: ,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String name = "샐리";
int num = 0;

class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

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
    _selectedEvents = [];
    prefsData();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(0),
          left: ScreenUtil().setWidth(0),
          right: ScreenUtil().setWidth(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(164)),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(28),
                ),
                Text(
                  "안녕, " + name + "!",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
              ],
              //
            ),
            SizedBox(
              height: ScreenUtil().setHeight(11),
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(28),
                ),
                Text(
                  "이번 달에 파란 기린과 " + num.toString() + "번 만났어요",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
              ],
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
                  width: 343,
                  height: 329,
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
                            markersMaxAmount:1,
                          ),

                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            //leftChevronMargin: EdgeInsets.only(10/0),
                          ),
                          startingDayOfWeek: StartingDayOfWeek.sunday,

                          onDaySelected: (date, events, holidays) {
                            setState(() {
                              _selectedEvents = events;
                              print(date);

                              if (_events[_calendarController.selectedDay] != null) {
                                _events[_calendarController.selectedDay]
                                    .add(_eventController.text);
                                print(_eventController.text);
                              } else {
                                _events[_calendarController.selectedDay] = [
                                  _eventController.text
                                ];
                              }
                              prefs.setString("events", json.encode(encodeMap(_events)));
                              _eventController.clear();
                            });
                          }, // onDaySelected: ,
                        ),

                        ..._selectedEvents.map((event) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/20,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                                child: Text(event,
                                  style: TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.bold,fontSize: 16),)
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

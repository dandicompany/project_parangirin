import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


String name = "샐리";
int num =0;

class Calender extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CalenderState();
}

class _CalenderState extends State<Calender>{

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();

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
            SizedBox(height: ScreenUtil().setHeight(77)),
            Row(
              children: [
                SizedBox(width: ScreenUtil().setWidth(28),),
                Text("안녕, "+name +"!",style: TextStyle(fontSize: ScreenUtil().setSp(24),fontFamily: 'Noto Sans KR',), ),
              ],
              //
            ),
            SizedBox(height: ScreenUtil().setHeight(11),),
            Row(
              children: [
                SizedBox(width: ScreenUtil().setWidth(28),),
                Text("이번 달에 파란 기린과 "+ num.toString()+"번 만났어요",style: TextStyle(fontSize: ScreenUtil().setSp(16),fontFamily: 'Noto Sans KR',),),
              ],
              //
            ),
            SizedBox(height: ScreenUtil().setHeight(27),),
            Row(
              children: [
                SizedBox(width: ScreenUtil().setWidth(16),),
                Container(
                  width: 343,
                  height: 329,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TableCalendar(
                          calendarController: _calendarController,
                          locale: 'ko-KR',
                          initialCalendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                            todayColor: Colors.white,
                            selectedColor: Colors.white,
                            todayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(20), color: Colors.black),
                            //selectedStyle: TextStyle(color: Colors.black,),
                            outsideDaysVisible : false,
                            weekdayStyle: TextStyle(color: AppTheme.colors.base3, fontSize: ScreenUtil().setSp(20)),
                            weekendStyle: TextStyle(color: AppTheme.colors.base3, fontSize: ScreenUtil().setSp(20)),
                            holidayStyle: TextStyle(color: AppTheme.colors.base3, fontSize: ScreenUtil().setSp(20)),
                          ),
                          headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              //leftChevronMargin: EdgeInsets.only(10/0),
                          ),
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                         // onDaySelected: ,
                        ),
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


import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';


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
    // TODO: implement build
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
                  child : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TableCalendar(calendarController: _calendarController,
                          initialCalendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                            selectedColor: AppTheme.colors.primary4,
                            todayStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                        )
                      ],
                    ),
                  ),

                ),

              ],
            ),

            // _buildProfile(context),
            // SizedBox(height: ScreenUtil().setHeight(41)),
            // _buildAccountInfo(context)
          ],
        ),
      ),
    );
  }
}


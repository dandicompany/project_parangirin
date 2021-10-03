import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/baby_info_confirm.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';

DateFormat yearFormat = DateFormat("yyyy");
DateFormat monthFormat = DateFormat("MM");
DateFormat dayFormat = DateFormat("dd");

class BabyInfoBirth extends StatefulWidget {
  final String name, nickName;
  BabyInfoBirth(this.name, this.nickName);
  @override
  _BabyInfoBirthState createState() => _BabyInfoBirthState(name, nickName);
}

class _BabyInfoBirthState extends State<BabyInfoBirth> {
  // List listMonth = new List.generate(12, (int index) => index + 1);
  // String valueChoose = "년도";
  String name, nickName;
  int birthdate;
  String birthYear, birthMonth, birthDay;
  bool selected = false;
  FirebaseProvider fp;
  _BabyInfoBirthState(this.name, this.nickName);
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(116),
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "아이의 이름은 ${this.name}(이)에요\n파란기린은 아이를 ${this.nickName}(이)라고 부를게요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16.0),
                      fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base2),
                ),
                SizedBox(width: double.infinity, height: ScreenUtil().setHeight(86)),
                Text(
                  "아이의 생년월일을 알려주세요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18.0),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.colors.base1),
                ),
                SizedBox(height: ScreenUtil().setHeight(6)),
                Text(
                  "아이의 연령에 맞는 이야기를 준비해둘게요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14.0),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.colors.base2),
                ),
                SizedBox(height: ScreenUtil().setHeight(39)),
                // Birth Date Input
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2012, 1, 1),
                        maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        this.birthdate = date.millisecondsSinceEpoch;
                        this.selected = true;
                        this.birthYear = yearFormat.format(DateTime.fromMillisecondsSinceEpoch(birthdate));
                        this.birthMonth = monthFormat.format(DateTime.fromMillisecondsSinceEpoch(birthdate));
                        this.birthDay = dayFormat.format(DateTime.fromMillisecondsSinceEpoch(birthdate));
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                      Column(
                        children: [
                          Text(
                            (birthYear != null)
                            ?"$birthYear" : "",
                            style: TextStyle(
                              color: AppTheme.colors.base2,
                              fontSize: ScreenUtil().setSp(18)
                            ),
                          ),
                          SizedBox(height:ScreenUtil().setHeight(2)),
                          Container(
                            height: ScreenUtil().setHeight(1),
                            width: ScreenUtil().setWidth(70),
                            color: AppTheme.colors.base2,
                          )
                        ],  
                      ),
                      Text(
                        " 년   ",
                        style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                      Column(
                        children: [
                          Text(
                            (birthMonth != null)
                            ?"$birthMonth" : "",
                            style: TextStyle(
                              color: AppTheme.colors.base2,
                              fontSize: ScreenUtil().setSp(18)
                            ),
                          ),
                          SizedBox(height:ScreenUtil().setHeight(2)),
                          Container(
                            height: ScreenUtil().setHeight(1),
                            width: ScreenUtil().setWidth(40),
                            color: AppTheme.colors.base2,
                          )
                        ],  
                      ),
                      Text(
                        " 월   ",
                        style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                      Column(
                        children: [
                          Text(
                            (birthDay != null)
                            ?"$birthDay" : "",
                            style: TextStyle(
                              color: AppTheme.colors.base2,
                              fontSize: ScreenUtil().setSp(18)
                            ),
                          ),
                          SizedBox(height:ScreenUtil().setHeight(2)),
                          Container(
                            height: ScreenUtil().setHeight(1),
                            width: ScreenUtil().setWidth(40),
                            color: AppTheme.colors.base2,
                          )
                        ],  
                      ),
                      Text(
                        " 일    ",
                        style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.colors.primary2,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  if (this.selected) {
                    logger.d("before pushing");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BabyInfoConfirm()));
                  }
                },
                height: ScreenUtil().setHeight(65),
                child: Text(
                  "다음",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                )
              )
            )
          )
        ],
      ),
    );
  }
}

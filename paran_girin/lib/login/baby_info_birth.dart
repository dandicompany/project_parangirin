import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/baby_info_confirm.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';

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
  int birthday;
  TextEditingController _yCon = TextEditingController();
  TextEditingController _mCon = TextEditingController();
  TextEditingController _dCon = TextEditingController();
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
                  "아이의 이름은 김기린이에요\n파란기린은 아이를 꿈돌이라고 부를게요",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Container(
                      width: ScreenUtil().setWidth(86),
                      child: TextField(
                        controller: _yCon,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                            vertical: ScreenUtil().setHeight(5)
                            )
                        ),
                      ),
                    ),
                    Text(
                      " 년  ",
                      style: TextStyle(
                          color: AppTheme.colors.base2,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(52),
                      child: TextField(
                        controller: _mCon,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                            vertical: ScreenUtil().setHeight(5)
                            )
                        ),
                      ),
                    ),
                    Text(
                      " 월  ",
                      style: TextStyle(
                          color: AppTheme.colors.base2,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(52),
                      child: TextField(
                        controller: _dCon,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                            vertical: ScreenUtil().setHeight(5)
                            )
                        ),
                      ),
                    ),
                    Text(
                      " 일",
                      style: TextStyle(
                          color: AppTheme.colors.base2,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                  ],
                ),

                FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2012, 1, 1),
                          maxTime: DateTime(2021, 2, 28), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        print('confirm $date');
                        setState(() {
                          this.birthday = date.microsecondsSinceEpoch;
                          this.selected = true;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.ko);
                    },
                    child: Text(
                      "생년 월일 선택하기",
                      style: TextStyle(
                          color: AppTheme.colors.primary1,
                          fontSize: ScreenUtil().setSp(18)),
                    )),

                // DropdownButton(
                //   value: valueChoose,
                //   onChanged: (newValue){
                //     setState(() {
                //       valueChoose = newValue;
                //     });
                //   },
                //   items: listMonth.map((valueItem) {
                //     return DropdownMenuItem(
                //       value: valueItem,
                //       child: Text(valueItem),
                //     );
                //   }).toList(),
                // ),

                // DefaultButton(
                //     text: "다음",
                //     press: () async {
                //       if (this.selected) {
                //         await fp.addChild(this.name, this.nickName, this.birthday);
                //         logger.d("before pushing");
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(
                //             builder: (context) => BabyInfoConfirm()));
                //       }
                //     },
                //     isInvert: !this.selected)
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
                onPressed: () async {
                  if (this.selected) {
                    await fp.addChild(this.name, this.nickName, this.birthday);
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

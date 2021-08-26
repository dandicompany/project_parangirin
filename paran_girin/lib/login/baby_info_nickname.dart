import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/baby_info_birth.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BabyInfoNickname extends StatefulWidget {
  final String name;
  BabyInfoNickname(this.name);
  @override
  _BabyInfoNicknameState createState() => _BabyInfoNicknameState(this.name);
}

class _BabyInfoNicknameState extends State<BabyInfoNickname> {
  String name;
  TextEditingController _nickCon = TextEditingController();
  _BabyInfoNicknameState(this.name);
  @override
  Widget build(BuildContext context) {
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
                  "아이의 이름은 ${this.name}(이)에요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16.0),
                      fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base2),
                ),
                SizedBox(
                    width: double.infinity, height: ScreenUtil().setHeight(86)),
                Text(
                  "아이의 별명을 알려주세요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18.0),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.colors.base1),
                ),
                SizedBox(height: ScreenUtil().setHeight(6)),
                Text(
                  "파란기린은 아이를 별명으로 부르며 대화할거에요",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14.0),
                      fontWeight: FontWeight.w400,
                      color: AppTheme.colors.base2),
                ),
                SizedBox(height: ScreenUtil().setHeight(32)),
                TextFormField(
                  controller: _nickCon,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (term){ 
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BabyInfoBirth(name, _nickCon.text)));
                    },
                  decoration: InputDecoration(
                      hintText: "꿈돌이",
                      hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18)),
                      suffixIcon: IconButton(
                        onPressed: _nickCon.clear,
                        icon: SvgPicture.asset("assets/icons/close.svg"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
                      ),
                    ),
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                  // obscureText: true, // for password
                  onChanged: (nextText){
                    setState(() {
                      // if(_nickCon.text.trim() != ""){
                      //   isSelected = true;
                      // }else{
                      //   isSelected = false;
                      // }
                      _nickCon.text = nextText.substring(0,6);
                      _nickCon.selection = TextSelection.fromPosition(TextPosition(offset: 6));
                    });
                    },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6)
                  ],
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BabyInfoBirth(name, _nickCon.text)));
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

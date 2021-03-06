import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/login/login_page.dart';

class EmailCheck extends StatefulWidget {
  @override
  _EmailCheckState createState() => _EmailCheckState();
}

class _EmailCheckState extends State<EmailCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(70),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "이메일을\n확인해주세요!",
                style: TextStyle(
                  // fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(24)
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(3),
              ),
              Row(
                children: [
                  Text(
                    "이메일이 오지 않나요? ",
                    style: TextStyle(
                      // fontFamily: 'Noto Sans KR',
                      // fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(12)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "다른 이메일로 가입하기",
                      style: TextStyle(
                        // fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(12)
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
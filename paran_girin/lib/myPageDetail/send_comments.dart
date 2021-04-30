import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';

class SendComments extends StatefulWidget {
  @override
  _SendCommentsState createState() => _SendCommentsState();
}

class _SendCommentsState extends State<SendComments> {
  // sendMail() async {
  //   String username = EMAIL;
  //   String password = PASS;

  //   final smtpServer = gmail(username, password);

  //   final message = Message()
  //     ..from = Address(username, 'Your name')
  //     ..recipients.add('wldbs6124@gmail.com')
  //     ..subject = '파란 기린에게 의견 보냅니다 :: 😀 :: ${DateTime.now()}'
  //     ..text = '내용 어쩌구 저쩌구';

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController textCon1;
    TextEditingController textCon2;
    
    return Scaffold(
      appBar: BaseAppBar(
        title: '의견 보내기',
      ),
      body: Container(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(16),
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
            ),
            child: Column(
              children: [
                RichText(
                    text: new TextSpan(
                  style: TextStyle(
                      // fontFamily: 'Noto Sans KR',
                      // fontWeight: FontWeight.w300,
                      color: AppTheme.colors.base2,
                      fontSize: ScreenUtil().setSp(12),
                      height: 1.3),
                  children: <TextSpan>[
                    new TextSpan(
                        text:
                            '더욱 발전하는 파란기린이 되기 위해 오늘도 여러분의 목소리에 귀를 기울입니다! 소중한 의견에 보답하기 위해 '),
                    new TextSpan(
                        text: '매일 한 분을 선발해 파란기린 굿즈를 보내드려요',
                        style: new TextStyle(color: AppTheme.colors.primary2)),
                  ],
                )),
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(40)
                ),
                // add press
                _buildGetComment(textCon1, true),
                SizedBox(height: ScreenUtil().setHeight(29)),
                _buildGetComment(textCon1, false)
              ],
            ),
          ),
          
    );
  }

  Column _buildGetComment(TextEditingController textCon, bool isCreative) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCreative ? "창의적인 질문을 추천해주세요!" : "바라는 점이나 아쉬운 부분은 없었나요?",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                    )
                  ),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                  TextField(
                    controller: textCon,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    decoration: InputDecoration(
                      // labelText:  "창의적인 질문을 추천해주세요!",
                      // labelStyle: TextStyle(fontSize: ScreenUtil().setSp(18)),
                      hintText: "어플을 사용하면서 불편했던 점, 마음에 들지 않는 질문과 스토리 등 다양한 의견을 보내주세요!",
                      hintStyle: TextStyle(fontSize: ScreenUtil().setSp(14)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(72),
                        height: ScreenUtil().setHeight(36),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          color: AppTheme.colors.primary2,
                          // onPressed: press,
                          onPressed: (){},
                          child: Text(
                            "보내기",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
  }
}

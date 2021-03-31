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
    return Scaffold(
      appBar: BaseAppBar(
        title: '의견 보내기',
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
            ),
            child: RichText(
                text: new TextSpan(
              style: TextStyle(
                  // fontFamily: 'Noto Sans KR',
                  // fontWeight: FontWeight.w300,
                  color: AppTheme.colors.base2,
                  fontSize: ScreenUtil().setSp(12)),
              children: <TextSpan>[
                new TextSpan(
                    text:
                        '더욱 발전하는 파란기린이 되기 위해 오늘도 여러분의 목소리에 귀를 기울입니다! 소중한 의견에 보답하기 위해 '),
                new TextSpan(
                    text: '매일 한 분을 선발해 파란기린 굿즈를 보내드려요',
                    style: new TextStyle(color: AppTheme.colors.primary2)),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

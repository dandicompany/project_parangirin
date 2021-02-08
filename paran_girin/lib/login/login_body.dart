import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/theme/app_theme.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key, 
    this.title, 
    this.description, 
    this.actionText, 
    this.loginInfo, 
    this.isEmail, 
    this.textPress, 
    this.buttonPress, 
  }) : super(key: key); 

  final String title, description, actionText, loginInfo;
  final bool isEmail;
  final GestureTapCallback textPress;
  final VoidCallback buttonPress;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title,
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
                  description,
                  style: TextStyle(
                    // fontFamily: 'Noto Sans KR',
                    // fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12)
                  ),
                ),
                GestureDetector(
                  onTap: textPress,
                  child: Text(
                    actionText,
                    style: TextStyle(
                      // fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(12)
                    ),
                  )
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: isEmail ? ScreenUtil().setHeight(91) : ScreenUtil().setHeight(126),
            ),
            Text(
              loginInfo,
              style: TextStyle(
              // fontFamily: 'Noto Sans KR',
              // fontWeight: FontWeight.w300,
              fontSize: ScreenUtil().setSp(16)
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(28),
            ),
            isEmail ? EmailForm():PasswordForm(),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(100),
            ),
            DefaultButton(
              text: "다음",
              press: buttonPress,
            )
          ],
        ),
      ),
    );
  }
}

class EmailForm extends StatefulWidget {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "paran@girin.com", 
              hintStyle: TextStyle(
                fontSize: ScreenUtil().setSp(16)
              )
            ),
            keyboardType: TextInputType.emailAddress,
          // obscureText: true, // for password
          ),
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(40),
          ),
          RichText(
          textAlign: TextAlign.center,
          text: new TextSpan(
            style: TextStyle(
            // fontFamily: 'Noto Sans KR',
            // fontWeight: FontWeight.w300,
            color: AppTheme.colors.base2,
            fontSize: ScreenUtil().setSp(12)
            ),
            children: <TextSpan>[
              new TextSpan(text: '계속 진행하면 파란기린의 '),
              new TextSpan(text: '이용 약관과\n개인정보 처리 방침에 동의', 
                style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(text: '한 것으로 간주됩니다.')
            ],
            )
          ),
        ]
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            // decoration: InputDecoration(
            //   errorText: "비밀번호가 일치하지 않아요 :(", 
            //   errorStyle: TextStyle(
            //     fontSize: ScreenUtil().setSp(12)
            //   )
            // ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true, // for password
          ),
        ]
      ),
    );
  }
}
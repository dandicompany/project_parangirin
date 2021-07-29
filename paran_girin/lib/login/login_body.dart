import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatelessWidget {
  const LoginBody(
      {Key key,
      this.title,
      this.description,
      this.actionText,
      this.loginInfo,
      this.isEmail,
      this.textPress,
      this.textCon,
      this.getInput = true})
      : super(key: key);

  final String title, description, actionText, loginInfo;
  final bool isEmail;
  final bool getInput;
  final GestureTapCallback textPress;
  final TextEditingController textCon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(90),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  // fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(24)),
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
                      fontSize: ScreenUtil().setSp(12)),
                ),
                GestureDetector(
                    onTap: textPress,
                    child: Text(
                      actionText,
                      style: TextStyle(
                          // fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(12)),
                    ))
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: isEmail
                  ? ScreenUtil().setHeight(91)
                  : ScreenUtil().setHeight(126),
            ),
            Text(
              loginInfo,
              style: TextStyle(
                  // fontFamily: 'Noto Sans KR',
                  // fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(16)),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(28),
            ),
            getInput
                ? (isEmail ? EmailForm(textCon) : PasswordForm(textCon))
                : SizedBox.shrink(),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(100),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailForm extends StatefulWidget {
  final TextEditingController textCon;
  EmailForm(this.textCon);
  @override
  _EmailFormState createState() => _EmailFormState(textCon);
}

class _EmailFormState extends State<EmailForm> {
  TextEditingController textCon;
  _EmailFormState(this.textCon);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        TextField(
          controller: textCon,
          decoration: InputDecoration(
              hintText: "paran@girin.com",
              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16))),
          keyboardType: TextInputType.emailAddress,
          // obscureText: true, // for password
        ),
        SizedBox(
          width: double.infinity,
          height: ScreenUtil().setHeight(40),
        ),
      ]),
    );
  }
}

class PasswordForm extends StatefulWidget {
  final TextEditingController textCon;
  PasswordForm(this.textCon);
  @override
  _PasswordFormState createState() => _PasswordFormState(textCon);
}

class _PasswordFormState extends State<PasswordForm> {
  TextEditingController textCon;
  _PasswordFormState(this.textCon);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        TextField(
          // decoration: InputDecoration(
          //   errorText: "비밀번호가 일치하지 않아요 :(",
          //   errorStyle: TextStyle(
          //     fontSize: ScreenUtil().setSp(12)
          //   )
          // ),
          controller: textCon,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true, // for password
        ),
      ]),
    );
  }
}

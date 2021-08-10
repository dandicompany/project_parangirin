import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/login/firebase_provider.dart';

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
      this.next,
      this.getInput = true})
      : super(key: key);

  final String title, description, actionText, loginInfo;
  final bool isEmail;
  final bool getInput;
  final GestureTapCallback textPress;
  final TextEditingController textCon;
  final Function next;

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
                ? (isEmail ? EmailForm(textCon, next) : PasswordForm(textCon, next))
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
  var next;
  EmailForm(this.textCon, this.next);
  @override
  _EmailFormState createState() => _EmailFormState(textCon, next);
}

class _EmailFormState extends State<EmailForm> {
  TextEditingController textCon;
  var next;
  _EmailFormState(this.textCon, this.next);
  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(children: [
        TextFormField(
          controller: textCon,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term){
            next();},
          // onFieldSubmitted: next,
          decoration: InputDecoration(
              hintText: "paran@girin.com",
              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16),),
              suffixIcon: IconButton(
                onPressed: textCon.clear,
                icon: SvgPicture.asset("assets/icons/close.svg"),
              )),
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
  var next;
  PasswordForm(this.textCon, this.next);
  @override
  _PasswordFormState createState() => _PasswordFormState(textCon, next);
}

class _PasswordFormState extends State<PasswordForm> {
  TextEditingController textCon;
  var next;
  _PasswordFormState(this.textCon, this.next);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        TextFormField(
          // decoration: InputDecoration(
          //   errorText: "비밀번호가 일치하지 않아요 :(",
          //   errorStyle: TextStyle(
          //     fontSize: ScreenUtil().setSp(12)
          //   )
          // ),
          controller: textCon,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term){
            next();},
          keyboardType: TextInputType.visiblePassword,
          obscureText: true, // for password
        ),
      ]),
    );
  }
}

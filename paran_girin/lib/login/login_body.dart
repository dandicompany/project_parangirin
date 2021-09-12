import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

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
        child: Form(
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
                    )
                  )
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
                  ? (isEmail ? EmailForm(textCon, next) : PasswordForm(textCon, next, null, null))
                  : SizedBox.shrink(),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(100),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class LoginBody2 extends StatelessWidget {
  // const LoginBody2(
  LoginBody2(
      {Key key,
      this.title,
      this.loginInfo,
      this.loginInfo2,
      this.textCon,
      this.textCon2,
      this.next,
      this.pwChecker, 
      this.formKey,
      this.actionText,
      this.textPress,
      this.getInput = true,})
      : super(key: key);

  final String title, loginInfo, loginInfo2, actionText;
  final bool getInput;
  final GestureTapCallback textPress;
  final TextEditingController textCon;
  final TextEditingController textCon2;
  final Function next, pwChecker;
  final formKey;
  final textFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(90),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)),
        child: Form(
          key: this.formKey,
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
              Row(
                children: [
                  Text(
                    "문제가 있으신가요? ",
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
                height: ScreenUtil().setHeight(50),
              ),
              Text(
                loginInfo,
                style: TextStyle(
                    // fontFamily: 'Noto Sans KR',
                    // fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(16)),
              ),
              // SizedBox( height: ScreenUtil().setHeight(8)),
              // PasswordForm(textCon, null, null, null),
              TextField(
                controller: textCon,
                textInputAction: TextInputAction.next, 
                focusNode: textFieldFocusNode,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      textFieldFocusNode.unfocus(); // Unfocus all focus nodes
                      textFieldFocusNode.canRequestFocus = false; // Disable text field's focus node request
                      textCon.clear();  // Do your stuff

                      //Enable the text field's focus node request after some delay
                      Future.delayed(Duration(milliseconds: 100), () {
                        textFieldFocusNode.canRequestFocus = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),),
                      child: SvgPicture.asset(
                        "assets/icons/close.svg",
                        color: AppTheme.colors.primary2,
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minHeight: ScreenUtil().setHeight(20),
                    minWidth: ScreenUtil().setWidth(20),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(24),
              ),
              Text(
                loginInfo2,
                style: TextStyle(
                    // fontFamily: 'Noto Sans KR',
                    // fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(16)),
              ),
              // SizedBox( height: ScreenUtil().setHeight(8)),
              PasswordForm(textCon2, next, this.pwChecker, this.formKey)
              // TextField(
              //   decoration: InputDecoration(hintText: 'TextField A'),
              //   textInputAction: TextInputAction.done, // Moves focus to next.
              // ),
            ],
          ),
        )
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
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        TextFormField(
          controller: textCon,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term){
            next();
          },
          validator: (text){
            print("validating email");
            if (!EmailValidator.validate(text)){
              var text = "잘못된 이메일 형식입니다.";
              logger.d(text);
              setState(() { 
                this.iconColor = Colors.red; 
              });
              return text;
            } else {
              setState(() { 
                this.iconColor = AppTheme.colors.primary2; 
              });
              return null;
            }
          },
          // onFieldSubmitted: next,
          decoration: 
        //   InputDecoration(
        //       hintText: "paran@girin.com",
        //       hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16),),
        //       suffixIcon: IconButton(
        //         onPressed: textCon.clear,
        //         icon: SvgPicture.asset("assets/icons/close.svg"),
        //       ),
        //       enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
        //       ),
        //       ),
        //   keyboardType: TextInputType.emailAddress,
        //   // obscureText: true, // for password
        // ),
        InputDecoration(
          hintText: "paran@girin.com",
          hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16),),
          suffixIcon: GestureDetector(
            onTap: textCon.clear,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),),
              child: SvgPicture.asset(
                "assets/icons/close.svg",
                color: iconColor,
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: ScreenUtil().setSp(20),
            minWidth: ScreenUtil().setSp(20),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        // SizedBox(
        //   width: double.infinity,
        //   height: ScreenUtil().setHeight(40),
        // ),
        )
      ]);
  }
}

class PasswordForm extends StatefulWidget {
  final TextEditingController textCon;
  final formKey;
  var next;
  var pwChecker;
  PasswordForm(this.textCon, this.next, this.pwChecker, this.formKey);
  @override
  _PasswordFormState createState() => _PasswordFormState(textCon, next, pwChecker, formKey);
}

class _PasswordFormState extends State<PasswordForm> {
  TextEditingController textCon;
  final formKey;
  var pwChecker;
  var next;
  // Color iconColor = AppTheme.colors.primary2;
  Color iconColor;

  _PasswordFormState(this.textCon, this.next, this.pwChecker, this.formKey);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        TextFormField(
          controller: textCon,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term){
            next();},
          validator: (text){
            print("validating password");
            if (this.pwChecker != null){
              var text = this.pwChecker();
              logger.d(text);
              setState(() { 
                this.iconColor = Colors.red; 
              });
              return text;
            } else {
              setState(() { 
                this.iconColor = AppTheme.colors.primary2; 
              });
              return null;
            }
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: textCon.clear,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),),
                child: SvgPicture.asset(
                  "assets/icons/close.svg",
                  color: iconColor,
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: ScreenUtil().setSp(20),
              minWidth: ScreenUtil().setSp(20),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.primary2, width: 2.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true, // for password
        ),
      ]);
  }
}

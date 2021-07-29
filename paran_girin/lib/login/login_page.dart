import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:provider/provider.dart';

enum enum_state { CHECKACC, SIGNUP, SIGNIN, PWCHECK, VERI }

class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textCon = TextEditingController();
  FirebaseProvider fp;
  bool doRemember = true;
  String _email = "", _pw = "", _pw_check = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  enum_state _state = enum_state.CHECKACC;

  @override
  Widget build(BuildContext context) {
    //  printScreenInformation();
    fp = Provider.of<FirebaseProvider>(context);
    _checkState();
    _textCon.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Stack(
        children: [ 
          Column(
            children: [
              _buildLoginBody(),
              // SNS login button
              if (_state == enum_state.CHECKACC)
                Column(
                  children: [
                    Text(
                      '혹은 SNS 계정으로 함께 해요',
                      style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(14),
                          color: AppTheme.colors.base2
                      )
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(105)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _googleButton(),
                          _facebookButton(),
                        ]
                      ),
                    ),
                  ],
                )
              ]
            ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.colors.primary2,
              width: double.infinity,
              child: FlatButton(
                onPressed: onClick(), 
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

  void _checkState() {
    if (fp.getUser() != null) {
      _state = enum_state.VERI;
    }
    logger.d(_state);
  }

  Function onClick() {
    logger.d(_state);
    switch (_state) {
      case enum_state.CHECKACC:
        return () {
          _email = _textCon.text;
          _checkAccount(_email);
        };
      case enum_state.SIGNIN:
        return () {
          _pw = _textCon.text;
          _signIn(_email, _pw);
        };
      case enum_state.SIGNUP:
        return () {
          _pw = _textCon.text;
          change2PWCheck();
        };
      case enum_state.PWCHECK:
        return () {
          _pw_check = _textCon.text;
          if (_pw_check == _pw) {
            _signUp(_email, _pw);
          } else {
            change2PWCheck();
          }
        };
      case enum_state.VERI:
        logger.d("vereerrrri");
        return () {
          logger.d("verification clicked");
          fp.reloadUser();
        };
    }
  }

  Widget _buildLoginBody() {
    switch (_state) {
      case enum_state.CHECKACC:
        return LoginBody(
            title: "파란기린은\n당신을 환영해요!",
            description: "",
            actionText: "",
            loginInfo: "로그인 혹은 회원가입을 위해\n이메일을 입력해 주세요",
            isEmail: true,
            textPress: () {},
            textCon: _textCon);
      case enum_state.SIGNIN:
        return LoginBody(
            title: "샐리,\n참 오랜만이에요!",
            description: "혹시 비밀번호를 잊으셨나요? ",
            actionText: "비밀번호 찾기",
            loginInfo: "이어서 비밀번호를 입력하고\n로그인을 완료하세요",
            isEmail: false,
            textPress: () {
              // find password page
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DefaultLayout()));
            },
            textCon: _textCon);
      case enum_state.SIGNUP:
        return LoginBody(
            title: "환영합니다!",
            description: "",
            actionText: "",
            loginInfo: "가입을 위해\n새로운 비밀번호를 입력해 주세요",
            isEmail: false,
            textPress: () {
              // find password page
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DefaultLayout()));
            },
            textCon: _textCon);
      case enum_state.PWCHECK:
        return LoginBody(
            title: "환영합니다!",
            description: "",
            actionText: "",
            loginInfo: "확인을 위해\n한 번 더 비밀번호를 입력해주세요",
            isEmail: false,
            textPress: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            textCon: _textCon);
      case enum_state.VERI:
        return LoginBody(
          title: "이메일을\n확인해주세요",
          description: "이메일이 오지 않나요? ",
          actionText: "다른 이메일로 가입하기",
          loginInfo: "인증메일을 보냈습니다\n메일 속 링크로 인증해주세요",
          isEmail: false,
          textPress: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          textCon: _textCon,
          getInput: false,
        );
    }
  }

  void initState() {
    logger.d("login page initiated");
    super.initState();
    getRememberInfo();
  }

  void dispose() {
    logger.d("login page disposed");
    setRememberInfo();
    _textCon.dispose();
    super.dispose();
  }

  void change2CheckAcc() {
    setState(() {
      _state = enum_state.CHECKACC;
      _email = "";
      _pw = "";
      _pw_check = "";
    });
  }

  void change2SignUp() {
    setState(() {
      _state = enum_state.SIGNUP;
      _pw = "";
      _pw_check = "";
    });
  }

  void change2PWCheck() {
    setState(() {
      _state = enum_state.PWCHECK;
      _pw_check = "";
    });
  }

  void change2SignIn() {
    setState(() {
      _state = enum_state.SIGNIN;
      _pw = "";
    });
  }

  void change2VERI() {
    setState(() {
      _state = enum_state.VERI;
    });
  }

  getRememberInfo() async {
    logger.d(doRemember);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doRemember = (prefs.getBool("doRemember") ?? false);
    });
    if (doRemember) {
      setState(() {
        _email = (prefs.getString("userEmail") ?? "");
        _pw = (prefs.getString("userPasswd") ?? "");
      });
    }
  }

  setRememberInfo() async {
    logger.d(doRemember);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    assert(doRemember != null);
    prefs.setBool("doRemember", doRemember);
    if (doRemember) {
      prefs.setString("userEmail", _email);
      prefs.setString("userPasswd", _pw);
    }
  }

  showLastFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }

  void _checkAccount(String id) async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Checking-Account...")
          ],
        ),
      ));
    bool result = await fp.signInWithEmail(id, "INVALIDPASSWORD");
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false) {
      String code = fp.getLastFBExceptionCode();
      if (code == 'user-not-found') {
        // Todo: Move to SignUp Page
        change2SignUp();
      } else if (code == 'wrong-password') {
        change2SignIn();
      } else {
        showLastFBMessage();
      }
    }
  }

  void _signUp(String id, String pw) async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-Up...")
          ],
        ),
      ));
    bool result = await fp.signUpWithEmail(id, pw);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false) {
      showLastFBMessage();
      _textCon.clear();
    } else {}
  }

  void _signIn(String id, String pw) async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-In...")
          ],
        ),
      ));
    bool result = await fp.signInWithEmail(id, pw);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == false) {
      showLastFBMessage();
      _textCon.clear();
    }
  }


  Widget _facebookButton() {
    return InkWell(
      onTap: () {
        fp.signInWithFacebookAccount();
      },
      child: Image.asset(
        "assets/icons/facebook.png",
        width: ScreenUtil().setWidth(62),
        height: ScreenUtil().setHeight(62),
      )
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: () {
        fp.signInWithGoogleAccount();
      },
      child: SvgPicture.asset(
        "assets/icons/google.svg",
        width: ScreenUtil().setWidth(62),
        height: ScreenUtil().setHeight(62),
      )
    );
  }
}

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/login/auth_page.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/theme/app_theme.dart';

bool button1 = false;
bool button2 = false;
bool button3 = false;
bool allbutton = false;
bool total = false;

double buttonscale = 1;
class PrivacyPolicy2 extends StatefulWidget {
  @override
  _PrivacyPolicy createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy2> {
  final termsText = '''**제1조(목적)**

이 약관은 단디 팀이 운영하는 파란기린 모바일 어플리케이션(이하 “앱”)의 서비스를 이용함에 있어 팀과 이용자의 권리의무 및 책임사항을 규정함을 목적으로 합니다.

**제2조(정의)**

- 팀 : 단디
- 앱 : 파란기린 모바일 어플리케이션(iOS, Android)
- 서비스 : 팀이 제공하는 일체의 서비스
- 회원 : 회원가입을 통해 서비스에 가입한 분
- 비회원 : 회원가입을 통해 서비스에 가입하지 않은 분
- 콘텐츠 : 회원 제작한 서비스 내에 있는 글, 사진, 영상, 음성 등의 것

**제3조(이용자격)**

1. 만 14세 이상만 "회원"이 될 수 있습니다.
2. 만 14세 미만은 서비스를 이용할 수 없으며, 만 14세에서 18세 사이의 사용자는 부모나 법정대리인이 서비스 약관에 동의하고 감독하는 조건 하에 서비스를 이용할 수 있습니다.
3. 회원은 본 서비스이용약관, 개인정보처리방침, 제3의 결제서비스 제공회사의 약관(때때로 변경될 수 있음)을 준수하며 이용불가 회원이 아니어야 합니다. 또한 귀하는 유죄판결을 받은 성범죄자가 아니어야 합니다.

**제4조(서비스의 제공 및 변경)**

팀은 다음과 같은 업무를 수행합니다.

1. 회원은 서비스 안에 있는 질문을 열람할 수 있습니다.
2. 회원은 질문에 대한 답변하는 모습을 촬영, 기록할 수 있습니다.
3. 위의 콘텐츠를 앱 내에서 공유하거나 다른 회원의 공유 콘텐츠를 열람할 수 있습니다.
4. 서비스 알람 앱 푸시 알림 및 SMS 알림 및 이메일 알림 전송을 제공할 수 있습니다.
5. 서비스 이용시간은 팀의 업무 또는 기술상 불가능한 경우 제외하고 연중무휴 1일 24시간으로 함을 원칙으로 합니다. 다만 서비스 정기점검 등 상유로 팀이 서비스 이용시간을 조정할 수 있습니다. 팀은 서비스를 개선하고 업데이트를 하여 회원의 편의성 향상을 위해 노력할 것이며, 고지할 변경사유가 생긴 경우 즉시, 귀하에게 통지 가능한 방법으로 통지합니다. (이메일, sms, 앱 푸시 알림, 통화 등)

**제5조(유효기간)**

영상의 유효기간은 회원이 영상을 촬영한 일자로부터 2년입니다. 

**제6조(회사의 의무)**

1. 팀은 서비스 이용에 문제가 생기지 않도록 서비스를 잘 관리합니다.
2. 팀은 콘텐츠 관리를 합니다.
콘텐츠는 앱 내에서 회원들에게 공유되는 모든 사진, 영상, 댓글 등이 가이드 대상이며, 방송통신심의위원회의 정보통신에 관한 심의규정 및 청소년보호위원회 심의규정에 따라 아래와 같은 내용이 포함된 콘텐츠는 가이드를 위반한 것으로 정의합니다.
- 국제 평화 질서 위반 등
- 헌정질서 위반 등
- 범죄 기타 법령 위반
- 선량한 풍속 기타 사회질서 위반 등: 성적인 내용, 폭력성, 잔혹성, 혐오성이 있는 내용, 사회통합 및 사회질서를 저해하는 정보, 타인의 권리를 침해하는 정보, 반인륜적 패륜적 행위 등 그 밖의 사회질서를 현저히 저해하는 정보
- 광고, 선전 등의 제한

**제7조(회원의 의무)**

1. 서비스이용약관 및 개인정보처리방침을 읽고, 내용을 확인하고, 동의합니다.
2. 아래 각 호의 행위를 하지 않음에 동의합니다.
- 법령이나 규정을 위반하는 행위
- 다른 사람의 지적 재산권, 개인 정보, 초상권 기타 법적 권리를 위반, 침해 또는 부당하게 사용하는 행위
- 불법적, 모욕적, 괴롭힘, 평판에 해롭거나 외설적이거나 음란하거나 외설적이거나 증오, 인종 차별 또는 기타 악의가 있는 내용을 게시하거나 공유하는 행위
- 원치 않는 광고 또는 무단 광고 또는 스팸과 같은 상업용 커뮤니케이션을 보내는 행위
- 사이트 또는 서비스에서 데이터를 수집하도록 설계된 스파이웨어를 포함하여 스파이더 링 또는 수확에 참여하거나 소프트웨어 사용에 참여하는 행위
- 컴퓨터나 관련 시스템의 사용을 방해, 손상 또는 방해하는 바이러스 또는 기타 컴퓨터 지침 또는 기술적 수단을 전송하는 행위
- 다른 사람을 스토킹, 욕설, 도배 또는 괴롭힘 등으로 해를 입히는 행위
- 개인이나 단체를 사칭하거나 피싱과 같은 다른 유사한 사기 행위
- 서비스 및 웹 페이지를 크롤링하는 수단을 사용하는 행위
- 사이트 또는 서비스를 보호하기 위해 당사 또는 당사의 공급자 또는 다른 제3자 (다른 사용자 포함)가 구현한 기술적 조치를 회피하려고 시도하는 행위
- 파란기린 워터마크를 편집, 변경, 수정, 삭제하거나 타인이 편집, 변경, 수정, 삭제하는 것에 협조 또는 유도하는 행위

위 의무를 다하지 못할 경우 회사는 회원에 대한 서비스의 일부 또는 전부를 제한하거나 중지할 수 있습니다.

**제8조(프라이버시)**

팀은 귀하의 프라이버시를 중요하게 생각하며 개인정보처리방침에 자세한 개인정보 수집, 이용, 제공 사항을 확인할 수 있습니다. 귀하는 서비스를 이용하기에 앞서 팀의 개인정보처리방침을 확인하고, 동의하여야 합니다.

**제9조(소유권)**

회원이 만든 영상 및 음성, 프로필사진, 소개 영상 등의 콘텐츠 일체의 지적재산권(저작재산권 포함) 및 원저작물을 바탕으로 하는 2차적 저작물 및 편집 및 배포권리, 초상권을 팀에게 귀속하기로 합의합니다. 

**제10조(양도금지)**

1. 회원의 서비스 받을 권리는 이를 타인에게 양도 또는 증여하거나 질권의 목적으로 사용할 수 없습니다.
2. 회원이 서비스에서 사용했던 계정 또는 닉네임을 타인에게 양도 또는 증여할 수 없습니다.

**제11조(공유 콘텐츠의 이용 범위)**

1. 서비스에 공개되어 있는 영상은 이용자 누구나 열람할 수 있습니다.
2. 서비스에 공개되어 있는 영상을 제 3자와 공유할 수 없습니다.
3. 이용자가 파란기린을 홍보하거나 이에 준하는 효과를 객관적으로 명백히 표시할 경우에는 예외적으로 이용자는 영상을 영리 목적으로 이용할 수 있습니다.

**제12조(준거법 및 관할법원)**

이 약관의 해석 및 팀과 회원간의 분쟁에 대하여는 대한민국의 법을 적용합니다.

**제13조(기타)**

현재 서비스이용약관 버전 : 버전 1.0

현재 서비스이용약관 시행일자 : 2021년 2월 20일
''';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: [
          _background(),
          Center(
          // Positioned(
          //   left: ScreenUtil().setWidth(16),
          //   top: ScreenUtil().setHeight(190),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: ScreenUtil().setHeight(464),
                width: ScreenUtil().setWidth(343),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //   //color: Colors.black,
                    //   width: 0.3,
                    // ),
                    color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: ScreenUtil().setHeight(22)),
                          Text(
                            "사용약관", 
                            style: TextStyle(
                              fontWeight: FontWeight.w500, 
                              fontSize: ScreenUtil().setSp(18.0), 
                              fontFamily: 'Noto Sans KR'
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(24)),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setSp(26),
                                height: ScreenUtil().setSp(26),
                                child: 
                                CircularCheckBox(
                                  value: button1,
                                  onChanged: (bool value) {
                                    setState(() {
                                      if (button1 == false){
                                        button1 = true;
                                        button2 = true;
                                        button3 = true;
                                        allbutton = true;
                                      }
                                      else if (button1 == true) {
                                        button1 = false;
                                        button2 = false;
                                        button3 = false;
                                        allbutton = false;
                                      }
                                    });
                                  },
                                )
                              ),
                              SizedBox(width: ScreenUtil().setWidth(8)),
                              Text("이용약관 및 개인정보 처리방침에 동의합니다.",
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(14.0))),
                            ],
                          ),
                          SizedBox(height: ScreenUtil().setHeight(26)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setSp(26),
                                height: ScreenUtil().setSp(26),
                                child: 
                              CircularCheckBox(
                                  value: button2,
                                  onChanged: (bool value) {
                                    setState(() {
                                      button2 = !button2;
                                      if (button2 == true && button3 == true){
                                        button1 = true;
                                        allbutton = true;
                                      }
                                      else if (button2 == false){
                                        button1 = false;
                                        allbutton = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(8)),
                              Text("파란기린 이용약관",style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(14.0))),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(18.0),
                              top: ScreenUtil().setHeight(6.0),
                              ),
                            child: Container(
                              height: ScreenUtil().setHeight(88),
                              width: ScreenUtil().setWidth(275),
                              child: SingleChildScrollView(
                                  child:Text(
                                    termsText, 
                                    style: TextStyle(color: AppTheme.colors.base2,
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12.0)))),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20.0)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setSp(26),
                                height: ScreenUtil().setSp(26),
                                child: CircularCheckBox(
                                  value: button3,
                                  onChanged: (bool value) {
                                // child: 
                                // InkWell(
                                //   child: Icon(
                                //     button3 ? Icons.architecture : Icons.archive),
                                //   onTap: () {
                                    setState(() {
                                      button3 = !button3;
                                      if (button2 == true && button3 == true){
                                        button1 = true;
                                        allbutton = true;
                                      }
                                      else if (button3 == false){
                                        button1 = false;
                                        allbutton = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(8.0)),
                              Text("개인정보 처리방침",style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(14.0))),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(18.0),
                              top: ScreenUtil().setHeight(6.0),
                            ),
                            child: Container(
                              height: ScreenUtil().setHeight(88),
                              width: ScreenUtil().setWidth(275),
                              child: SingleChildScrollView(
                                  child:Text("*** 수정하기 ****** 파란기린은 단디 팀이 운영하는 서비스로, 팀은 파란기린 서비스 제공과 관련하여 귀하의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 팀은 팀이 서비스(이용약관에서 정의됨)를 통하여 이용자로부터 수집하는 개인정보(아래에서 정의됨)의 처리에 대해 설명하기 위해 본 개인정보처리방침을 작성하였습니다.", 
                                  style: TextStyle(
                                    color: AppTheme.colors.base2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12.0)))),
                              // 여기 내용 수정해야됨 !!!
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(1.5)),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(16),
                      //     bottomRight: Radius.circular(16)
                      //   ),
                        // child: 
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(60),
                          child: FlatButton(
                            // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),),
                            child: Text('동의합니다', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                            onPressed: () => {
                              setState(() {
                                if (button1 == true && button2 == true && button3==true){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => AuthPage()));
                                };
                              }),
                            },
                            color: allbutton ? Colors.blue : Colors.grey,
                            textColor: Colors.white,
                          ),
                        // ),
                      ),
                    // )
                  ],
                ),
          ),
            ),
          ),

      ],
      )
    );
  }
  Widget _buildLoginBody() {
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
                    "파란기린은\n당신을 환영해요!",
                    style: TextStyle(
                    //fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(24)),
                    ),
    ])));
  }

  Widget _background(){
    return Stack(
      children: [
        _buildLoginBody(),
        Opacity(
          opacity: 0.25,
          child: Container(
          decoration: BoxDecoration(color: Colors.black),
          ),),
      ],
    );
  }
}

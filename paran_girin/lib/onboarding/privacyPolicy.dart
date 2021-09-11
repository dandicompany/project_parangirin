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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: [
          _background(),
          Positioned(
              left: ScreenUtil().setWidth(16),
            top: ScreenUtil().setHeight(190),
            child:Container(
              height: ScreenUtil().setHeight(540),
              width: ScreenUtil().setWidth(343),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(22)),
                  Text("사용약관", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Noto Sans KR'),),
                  SizedBox(height: ScreenUtil().setHeight(24)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.scale(
                        scale: buttonscale,
                        child: CircularCheckBox(
                          value: button1,
                          onChanged: (bool value) {
                            setState(() {
                              button1 = !button1;
                              button2 = !button2;
                              button3 = !button3;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(4),),
                      Text("아래 이용 약관 및 개인 정보 처리 방침에 동의합니다.",
                          style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.scale(
                        scale: buttonscale,
                        child: CircularCheckBox(
                          value: button2,
                          onChanged: (bool value) {
                            setState(() {
                              button2 = !button2;
                            });
                          },
                        ),
                      ),
                      //SizedBox(width: ScreenUtil().setWidth(2),),
                      Text("파란기린 이용 약관",style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: ScreenUtil().setWidth(49.0),),
                      Container(
                        height: ScreenUtil().setHeight(100),
                        width: ScreenUtil().setWidth(275),
                        child: SingleChildScrollView(
                            child:Text('''

파란기린은 단디 팀이 운영하는 서비스로, 팀은 파란기린 서비스 제공과 관련하여 귀하의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 팀은 팀이 서비스(이용약관에서 정의됨)를 통하여 이용자로부터 수집하는 개인정보(아래에서 정의됨)의 처리에 대해 설명하기 위해 본 개인정보처리방침을 작성하였습니다. 본 개인정보처리방침에 정의되지 않은 용어는 파란기린에 적용되는 각 이용약관에 명시된 의미를 지닙니다. 팀은 개인정보처리방침을 개정하는 경우 앱 공지사항(또는 개별공지)를 통하여 공지할 것입니다.

본 '개인정보 처리방침’은 파란기린 서비스를 이용하는 모든 이용자에게 적용됩니다.

**제1조(팀이 수집하는 개인정보의 항목 및 수집방법)**

파란기린이 제공하는 대부분의 서비스는 회원가입 후, 이용이 가능합니다.

회원가입을 하시는 경우, 로그인하여 다양한 서비스들을 이용하실 수 있습니다.

파란기린은 회원가입 과정에서 서비스 이용을 위해 필요한 최소한의 정보만을 수집 및 활용합니다. 이러한 이유로 일부 서비스에서는 이용자의 동의를 받아 개인정보를 추가로 수집하는 경우도 있습니다.

파란기린 서비스와 관련하여 팀이 수집 및 이용하는 개인정보 항목은 다음과 같습니다.

개인정보 항목: 채우기

- 예시

    성명, 국적, 거주 도시, 거주지 주소, 이메일, 휴대전화번호, 로그인ID, 생년월일, 주민등록번호, 신용카드정보, 은행계좌번호, SNS계정 정보(이메일 등), 서비스 이용 기록(방문일시, 기기정보, 쿠키, 접속 IP 정보), 결제기록, 설문조사 내용, 문의내용

파란기린 서비스와 관련하여 팀이 수집하는 방법은 다음과 같습니다.

채우기

- 예시

    가입화면, 인플루언서 상세 화면, 댓글 화면, 문의 화면, 본인인증화면, 결제화면, 설문조사 화면, 이벤트 화면

**제2조(개인정보의 처리 목적)**

팀은 회원가입 및 관리(이용자 식별, 계정 보안, 서비스 이용 경험 향상, 보안, 이메일 주소 인증), 문의사항 처리(채용 기회, 설문조사, 기타 홍보 자료 및 제안 등), 재화 또는 서비스 제공, 마케팅 등의 홍보에의 활용(공개적으로 공유된 정보는 팀 서버에 저장되어 다른 사용자들이 볼 수 있게 됩니다. 팀은 다른 사용자에게 보내거나 공개적으로 공유하도록 선택한 개인정보를 책임지지 않습니다.) 등의 목적으로 개인정보를 사용합니다. 이용 목적이 변경될 시에는 사전동의를 구할 것입니다. 또한, 팀은 귀하의 개인 식별 정보에서 귀하의 이름과 같은 정보를 제외시켜 익명 정보를 생성할 수 있습니다. 팀은 익명 정보를 이용하여 서비스 내용을 향상시킬 수 있습니다. 팀은 임의의 목적으로 익명 정보를 이용할 수 있는 권리를 가지며 익명 정보를 단독 재량으로 제 3 자에게 공개합니다.

**제3조(개인정보의 보유기간 및 파기)**

팀은 귀하의 개인정보를 수집된 시점으로부터 귀하가 회원 탈퇴를 요청하거나 개인정보 수집∙이용에 대한 동의를 철회할 때까지 보유 및 이용됩니다. 보유 기간이 경과하거나 이용 목적이 달성된 경우, 관계 법령(전자상거래에서의 소비자 보호 등에 관한 법률 등)에서 개인정보를 보존할 의무를 정하고 있는 다음과 같은 경우를 제외하고는 지체 없이 해당 개인정보를 복구 또는 재생이 불가능한 방법으로 파기합니다.)

- 전자상거래 등에서의 소비자보호에 관한 법률
    - 보존 대상 및 기간:
    - 계약 또는 청약철회 등에 관한 기록(5년)
    - 대금결제 및 재화 등의 공급에 관한 기록(5년)
    - 소비자의 불만 또는 분쟁처리에 관한 기록(3년)
    - 표시/광고에 관한 기록(6개월)
- 신용정보의 이용 및 보호에 관한 법률
    - 보존 대상 및 기간:
    - 신용정보의 수집/처리 및 이용 등에 관한 기록(3년)
- 국세기본법
    - 보존 대상 및 기간:
    - 거래에 관한 장부 및 증거서류(5년)
- 통신비밀보호법
    - 보존 대상 및 기간 :
    - 컴퓨터통신 또는 인터넷의 로그기록자료, 정보통신기기의 위치를 확인할 수 있는 접속지의 추적자료 등(3개월)
- 정보통신망 이용촉진 및 정보보호에 관한 법률 제44조의5 및 시행령 제29조
    - 보존 대상 및 기간 :
    - 본인확인에 관한 기록보존(6개월)

**제4조(귀하의 개인정보 이전 (개인정보 처리위탁 또는 제3자 제공))**

1. 개인정보의 처리위탁
- 귀하의 개인정보는 아래와 같이 개인정보의 처리 위탁을 위해 수탁자에게 이전됩니다.
- Amazon Web Services – 서비스 제공을 위한 IT 인프라 관리, 핸드폰 번호 인증, 홍보 메시지 발송, 서비스 공지, 인플루언서 - 미션 전달에 필요한 정보, 미션 완료 후 지체없이 파기, PG사(페이플)-로그인ID, 이름, 신용카드 정보, 은행계좌 정보, 5년간 보유 및 이용

2. 개인정보의 국외이전

- 귀하의 개인정보는 귀하가 웹사이트상 입력하는 등의 방법으로 수집되는 순간 아래의 제공받는 자가 접근 가능한 서버에 저장되는 방식으로 국외로 이전됩니다. Amazon Web Service (US,EU)(이용 목적 - 서비스 제공을 위한 IT 인프라 관리, 항목 – 당사가 수집·이용하는 개인정보 항목 일체, 이용기간 – 회원탈퇴 시 또는 개인정보 처리에 대한 동의 철회 시까지, 연락처 - aws-korea-privacy@amazon.com)

이 개인정보보호방침에 달리 명시된 경우를 제외하고, 팀은 웹사이트 또는 서비스에서 수집 한 개인정보를 제 3 자에게 판매, 거래, 공유 또는 대여하지 않습니다.

**제5조(귀하의 개인정보에 관한 권리)**

귀하는 개인정보의 처리에 대한 정보를 제공받을 권리, 개인정보의 처리에 관한 동의 여부, 동의 범위 등을 선택하고 결정할 권리, 개인정보의 처리 여부를 확인하고 개인정보에 대하여 열람(사본의 발급을 포함)을 요구할 권리, 개인정보의 처리 정지, 정정·삭제 및 파기를 요구할 권리, 개인정보의 처리로 인하여 발생한 피해를 신속하고 공정한 절차에 따라 구제받을 권리를 가집니다. 귀하가 만 14세 미만의 아동일 경우 귀하의 법정대리인이 직접 행사할 수도 있습니다. 회사는 해당 정보를 보관하여야 하며 삭제하여서는 안될 의무를 부담할 수도 있다는 점을 참고하시기 바랍니다. (또는 해당 정보를 특정 기간 동안 보관해야 할 수도 있으며 그 경우는 보관 의무를 준수한 후에야 삭제 요청에 응할 것임).

**제6조(귀하의 개인정보에 대한 보안)**

팀은 팀이 보유한 개인정보의 손실, 오용 및 변경으로부터 보호하기 위해 상업적으로 합당한 보안 조치를 취하고 있습니다. 팀은 개인정보의 안전성 확보를 위해 대표적으로 다음과 같은 조치를 취하고 있습니다.

1. 관리적 : 내부관리계획 수립 및 시행, 주기적 직원 교육 등
2. 기술적 : 개인정보처리시스템 등 정보 접근 권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치
3. 물리적: 전산실, 자료보관실 등의 출입 통제

**제7조(연락처 정보)**

회사는 이 개인정보처리방침에 관한 귀하의 의견이나 질문을 환영합니다. 아래에 문의하십시오.

개인정보 보호책임자 : 빙유진

개인정보 보호책임자 이메일 : dbwls2088@kaist.ac.kr

기타 개인정보침해에 대한 신고 또는 상담이 필요하신 경우에는 아래 기관으로 문의하시기 바랍니다.

개인정보침해신고센터 (www.118.or.kr / 국번없이 118)

대검찰청 사이버범죄수사단 (www.spo.go.kr / 02-3480-3571)

경찰청 사이버테러대응센터 (www.ctrc.go.kr / 국번없이 182)

**제8조(본 개인정보처리방침의 개정)**

팀은 개인정보처리방침을 수시로 수정할 수 있으며, 실질적으로 변경할 경우 변경 내용을 이메일 주소로 보내거나 공지사항을 게시할 것입니다. 변경사항은 이메일 통지 또는 웹사이트 변경 7일 이후 중 이른 시점부터 효력이 발생합니다. 개인정보 취급방침의 변경 효력 발생 이후 회원이 지속적으로 팀의 서비스를 이용하는 경우 회원이 해당 변경 사항을 승인한 것으로 간주됩니다. 본 개인정보 취급방침의 변경 내용에 동의하지 않는 경우, 회원은 팀의 서비스 이용을 취소할 수 있습니다.

**제9조(준거법 및 관할법원)**

이 약관의 해석 및 회사와 회원간의 분쟁에 대하여는 대한민국의 법을 적용합니다.

**제10조(기타)**

현재 개인정보처리방침 버전 : 버전 1.0

현재 개인정보처리방침 시행일자 : 2021년 2월 20일

이전 개인정보처리방침: 없음
''', style: TextStyle(color: Colors.black,
                                fontSize: 12.0))),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.scale(
                        scale: buttonscale,
                        child: CircularCheckBox(
                          value: button3,
                          onChanged: (bool value) {
                            setState(() {
                              button3 = !button3;

                            });
                          },
                        ),
                      ),
                      //SizedBox(width: ScreenUtil().setWidth(),),
                      Text("파란기린 이용 약관",style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: ScreenUtil().setWidth(49.0),),
                      Container(
                        height: ScreenUtil().setHeight(100),
                        width: ScreenUtil().setWidth(275),
                        child: SingleChildScrollView(
                            child:Text("파란기린은 단디 팀이 운영하는 서비스로, 팀은 파란기린 서비스 제공과 관련하여 귀하의 개인정보를 보호하기 위해 최선을 다하고 있습니다. 팀은 팀이 서비스(이용약관에서 정의됨)를 통하여 이용자로부터 수집하는 개인정보(아래에서 정의됨)의 처리에 대해 설명하기 위해 본 개인정보처리방침을 작성하였습니다.", style: TextStyle(color: Colors.black,
                                fontSize: 12.0))),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(30)),
                  Stack(
                    children: [
                      SizedBox(width: double.infinity,
                        height: ScreenUtil().setHeight(30),
                        child: ColoredBox(color: Colors.grey,)),
                      SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(53),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),),
                          child: Text('동의합니다', style: TextStyle(fontSize: ScreenUtil().setSp(16))),
                          onPressed: () => {
                            setState(() {
                              button1 = !button1;
                              button2 = !button2;
                              button3 = !button3;
                              if (button1 == true && button2 == true && button3==true){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                              };
                            }),
                          },
                          color: Colors.grey,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
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

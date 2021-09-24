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
  final privacyText = '''
  • '단디 팀'은 (이하 '플랫폼'은) 회원님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다. 플랫폼은 개인정보취급방침을 통하여 회원님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다. 플랫폼은 개인정보취급방침을 개정하는 경우 앱 내 공지사항(또는 개별공지)을 통하여 공지할 것입니다.

**■ 수집하는 개인정보의 항목 및 수집방법**

플랫폼은 회원으로부터 모바일에서 다음과 같은 방법으로 정보를 수집합니다.

가. 프로필 정보 : (자녀) 성명, 이메일, 비밀번호, (자녀) 생년월일, 프로필 사진 등이 이에 해당합니다.

나. 제 3자로부터 제공받는 정보 :  제3의 소셜네트워크 계정( Facebook, Google ) 정보를 이용하여 본 플랫폼을 이용하거나 본 플랫폼에 등록 또는 로그인하는 경우, 회원은 회원의 이용자명, 공개 프로필 및 해당 계정과 관련된 여타 정보를 당사에게 제공하게 되거나 동 정보를 당사에게 제공하는 것을 허용하게 됩니다.

다. 직접 전달한 이용자 콘텐츠 정보 : 당사는 이용자가 '우리 아이 뽐내기' 를 통해 당사에 전달한 이용자 콘텐츠를 수집합니다. 이용자 콘텐츠는 이용자가 당사의 서비스를 이용해 생성한 비디오 결과물을 의미합니다.

라. 그 밖의 이용자 콘텐츠 정보 : 당사는 서비스 개선을 목적으로 이용자 콘텐츠의 영상 길이 정보를 수집합니다. 이용자가 이용자 콘텐츠를 업로드 또는 저장한 경우에만 수집합니다.

마. 당사는 사용자의 서비스 이용기록 ( 접속 시간 및 이용 시간 , 특정 화면에서 화면 터치 로그 등 ) 을 수집합니다. 또한 OS 종류 및 버전 등 자동으로 생성된 정보를 수집할 수 있으며, 당사는 해당 정보들은 유저 분석 및 서비스 개선 목적으로 이용할 수 있습니다.

**[Google Firebase Analytics를 이용한 애플리케이션 로그 분석]** 저희 플랫폼은 Google에서 제공하는 애플리케이션 사용 분석 도구인 Firebase Analytics를 사용하고 있습니다. 이 경우 플랫폼은 애플리케이션 로그와 관련되지 않은 개인 식별 정보를 수집하지 않습니다. 

• 만약 서비스 이용 도중 위에서 밝힌 내용 이외에 추가적으로 개인정보 수집이 필요한 경우, 플랫폼은 회원에게 사전에 이러한 사실을 고지하고 동의를 받습니다. 예를 들어 위치기반 서비스와 같이 모바일 서비스 이용시 새로운 개인정보 혹은 개인위치정보를 수집해야 하는 상황이 발생하면 회사는 회원에게 사전에 고지하고 동의받은 회원에 한해서만 정보를 수집합니다.

**■ 개인정보의 수집 및 이용목적**

• 플랫폼은 수집한 개인정보를 다음의 목적을 위해 활용합니다. 이용자가 제공한 모든 정보는 아래 목적에 필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 사전 동의를 구할 것입니다.

• 회원제 서비스 이용에 따른 본인인증 및 본인확인, 개인식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 중복가입 확인, 가입의사 확인, 연령확인, 회원자격 유지 및 관리, 만 14세 미만 아동 개인정보 수집 시 법정대리인 동의 여부 확인, 만 18세 미만 아동 및 청소년의 회원가입 시 법정대리인의 동의 여부 확인 및 법정대리인 본인확인

• 서비스 시스템 고도화

•  이벤트 및 프로모션 진행, 마케팅 및 광고 : 통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스 유효성 확인, 접속 빈도 파악, 회원의 서비스 이용에 대한 통계, 이벤트 및 광고성 정보와 참여기회 제공

**■ 개인정보의 보유 및 이용기간**

• 원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

• 보존 항목 : 로그인ID , 접속 IP 정보ㆍ보존 근거 : 불량 회원 제거ㆍ보존 기간 : 1년ㆍ보존 항목 : 결제기록ㆍ보존 근거 : 물품확인ㆍ보존 기간 : 1년

• 그리고 관계법령의 규정에 의하여 보존할 필요가 있는 경우 플랫폼은 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.

• 표시/광고에 관한 기록 : 6개월 (전자상거래등에서의 소비자보호에 관한 법률)ㆍ계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)ㆍ대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)ㆍ소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의 소비자보호에 관한 법률)ㆍ신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년 (신용정보의 이용 및 보호에 관한 법률)

**■ 개인정보의 파기절차 및 방법**

• 플랫폼은 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.

- 파기 절차

• 회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정기간 저장된 후 파기되어 집니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유 되어지는 이외의 다른 목적으로 이용 되지 않습니다.

- 파기 방법

• 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.

**■ 이용자 및 법정대리인의 권리와 그 행사방법**

• 이용자 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다.이용자 혹은 만 14세 미만 아동의 개인정보 조회 수정을 위해서는 ‘개인정보변 경’(또는 ‘회원정보수정’ 등)을 가입해지(동의철회)를 위해서는 “회원탈퇴”를 클릭 하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다. 혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다. 회원님께서 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까 지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자 에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이 이루어지도록 하겠습니다. 플랫폼은 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보를 “플랫폼이 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.

**■ 개인정보에 관한 민원서비스**

• 플랫폼은 회원님의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다.

• CS 담당 부서 : dandicompany2021@gmail.com

• 개인정보관리책임자 성명 : 방유진 (이메일 : dandicompany2021@gmail.com)

• 회원님께서는 플랫폼의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. 플랫폼은 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다. 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.

• 1.개인분쟁조정위원회 (www.1336.or.kr / ☎ 1336)2.정보보호마크인증위원회 (www.eprivacy.or.kr / ☎ 02-580-0533~4)3.대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr / ☎ 02-3480-3600)4.경찰청 사이버테러대응센터 (www.ctrc.go.kr / ☎ 02-392-0330)

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
                                  child:Text(
                                    privacyText,
                                  style: TextStyle(
                                    color: AppTheme.colors.base2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12.0)))),
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

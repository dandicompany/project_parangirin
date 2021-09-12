import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';

class AboutParanGirin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '파란기린 소개'
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(25),
          horizontal: ScreenUtil().setWidth(24)
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: new TextSpan(
                style: TextStyle(
                    color: AppTheme.colors.base1,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(16),
                    height: 1.6
                  ),
                children: <TextSpan>[
                  new TextSpan(
                    text: 'DANDI',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24)
                    )
                  ),
                  new TextSpan(
                    text: '는 \n더 많은 부모와 아이가 대화하기를 바랍니다.                  '
                  ),
                  new TextSpan(
                    text: '\n\n\n우리가 기여할 수 있는 행복을 만들자\n\n\n',
                    style: TextStyle(
                      color: AppTheme.colors.primary2,
                      fontWeight: FontWeight.w500,
                      height: 1
                    )
                  ),
                ],
              )
            ),
            Image.asset(
              "assets/images/aboutParan_1.png",
              width: ScreenUtil().setWidth(112),
              height: ScreenUtil().setHeight(107),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(27)
            ),
            RichText(
              text: new TextSpan(
                style: TextStyle(
                    color: AppTheme.colors.base1,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(14),
                    height: 1.6
                    ),
                children: <TextSpan>[
                  new TextSpan(
                    text: 'DANDI는 KAIST 학부생들로 구성되어 있습니다. 바쁜 일상 속 현대인들에게 우리가 가진 기술과 디자인으로 행복을 선물하고 싶습니다.',
                  ),
                  new TextSpan(
                    text: '\n\n\n에듀테인먼트를 실현하자\n\n\n',
                    style: TextStyle(
                      color: AppTheme.colors.primary2,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16)
                    )
                  ),
                ],
              )
            ),
            Image.asset(
              "assets/images/aboutParan_2.png",
              width: ScreenUtil().setWidth(245),
              height: ScreenUtil().setHeight(117),
            ),
            RichText(
              text: new TextSpan(
                style: TextStyle(
                    color: AppTheme.colors.base1,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(14),
                    height: 1.6),
                children: <TextSpan>[
                  new TextSpan(
                    text: '\n\n파란기린의 캐릭터와 스토리는 부모와 아이 사이에 녹아듭니다. 그들이 ',
                  ),
                  new TextSpan(
                    text: '대화할 수 있는 기회',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )
                  ),
                  new TextSpan(
                    text: '를 만들어주고, 이 모든 과정을 ',
                  ),
                  new TextSpan(
                    text: '놀이처럼',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )
                  ),
                  new TextSpan(
                    text: ' 즐기게 합니다. 교육의 본질을 잊지 않은 채, 하나뿐인 추억과 진정한 행복에 집중했습니다.',
                  ),
                ],
              )
            ),
            RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                style: TextStyle(
                  color: AppTheme.colors.base1,
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(16),
                  height: 1.6
                ),
                children: <TextSpan>[
                  new TextSpan(
                    text: '\n\nDANDI는 대한민국의 교육에',
                  ),
                  new TextSpan(
                    text: '\n새로운 변화의 바람',
                    style: TextStyle(
                      color: AppTheme.colors.primary2,
                      fontWeight: FontWeight.w400
                    )
                  ),
                  new TextSpan(
                    text: '이 불기를 기대합니다. \n\n\n',
                  ),
                  new TextSpan(
                    text: '아이의 미래를 함께 꿈꾸겠습니다.\n\n파란기린 목에 올라타\n아이가 넓은 세상을 바라보는 그 날까지\n\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(14)
                    )
                  ),
                ],
              )
            ),
            Image.asset(
              "assets/images/aboutParan_3.png",
              width: ScreenUtil().setWidth(54),
              height: ScreenUtil().setHeight(78),
            ),
            SizedBox(height: ScreenUtil().setHeight(60))
          ],
        ),
      ),
      
    );
  }
}
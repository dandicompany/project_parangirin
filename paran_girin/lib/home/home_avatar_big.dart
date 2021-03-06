import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:paran_girin/layout/default_icon_botton.dart';
import 'package:paran_girin/theme/app_theme.dart';

class HomeAvatarBig extends StatelessWidget {
  const HomeAvatarBig({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment(0.0, 0.85),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),
            child: Container(
              width: double.infinity,
              // height: ScreenUtil().setHeight(728),
              height: ScreenUtil().setHeight(812),
              child: Image.asset(
                "assets/avatars/default_background.png",
                fit: BoxFit.cover
              ),
              // child: Lottie.asset("assets/avatars/default_background.png"),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(16.0)
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(74)
                      ),
                    Text(
                      "오늘의 질문에 이미 답변을 하셨네요",
                      // todayDone ? "오늘의 질문에 이미 답변을 하셨네요":"오늘의 질문",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: AppTheme.colors.base2,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15)),
                    Text(
                      // todayDone ? "내일은 어떤 질문이\n기다리고 있을까요?":"타임 캡슐에 담고 싶은\n나의 물건은?",
                      "내일은 어떤 질문이\n기다리고 있을까요?",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        // color: todayDone ? AppTheme.colors.base2:AppTheme.colors.base1,
                        color: AppTheme.colors.base1,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(595),
                child: Image.asset(
                  'assets/images/onboard_2.png',
                  fit: BoxFit.cover,
                ),
                // child: Lottie.asset(
                //   'assets/avatars/lurking-cat.json',
                //   fit: BoxFit.cover,
                // ),
              ),
            ],
          ),
          // 버튼에 겹쳐져서 안보임
          // GestureDetector(
          //   onTap: () {},
          //   child: Text(
          //     "새로운 질문을 추천해주세요!",
          //     style: TextStyle(
          //       // fontFamily: 'Noto Sans KR',
          //       fontSize: ScreenUtil().setSp(12),
          //       color: AppTheme.colors.base2
          //     ),
          //   )
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(16.0)),
            child: DefaultIconButton(
              text: "추천 질문으로 대화하기",
              icon: "assets/icons/camera.svg",
              isInvert: true,
              press: () {}
            ),
          ),
        ],
      ),
    );
  }
}
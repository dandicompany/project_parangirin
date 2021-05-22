import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/home/home_avatar_big.dart';
import 'package:paran_girin/home/sharing_my_answers.dart';
import 'package:paran_girin/home/post_card.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/myPageDetail/send_comments.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/utils/FadePageRoute.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/models/schema.dart';

class HomeBody extends StatefulWidget {
  _HomeBody createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(150)),
      child: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          child: Column(children: <Widget>[
            Column(
              children: <Widget>[
                HomeAvatar(),
                SizedBox(height: ScreenUtil().setHeight(28)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "생각 뽐내기",
                        style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                      Text(
                        "2021년 2월 둘째 주",
                        style: TextStyle(
                            color: AppTheme.colors.base2,
                            fontSize: ScreenUtil().setSp(12)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(24)),
                SizedBox(
                  height: 500,
                  child: StreamBuilder(
                      stream: fp.getFirestore().collection('posts').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List<QueryDocumentSnapshot> posts =
                              snapshot.data.docs;
                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Post post = Post.fromJson(posts[index].data());
                                return PostCard(post);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                    height: ScreenUtil().setHeight(8));
                              },
                              itemCount: posts.length);
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ),
                SizedBox(height: ScreenUtil().setHeight(16)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16)),
                  child: DefaultButton(
                    text: "우리 아이 뽐내기",
                    isInvert: true,
                    press: () {
                      Navigator.of(context)
                          .push(FadePageRoute(widget: SharingMyAnswers()));
                    },
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(48)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "의견 보내기",
                        style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(23)),
                      DefaultButton(
                        text: "바로 가기",
                        isInvert: true,
                        press: () {
                          Navigator.of(context)
                              .push(FadePageRoute(widget: SendComments()));
                        },
                      ),
                      SizedBox(height: ScreenUtil().setHeight(14)),
                      Center(
                        child: Text(
                          "재미있는 아이디어, 소중한 질문, 불만족스러운 의견 등\n파란기린이 발전할 수 있도록 다양한 의견을 공유해주세요!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.colors.base3,
                              fontSize: ScreenUtil().setSp(12),
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}

class HomeAvatar extends StatelessWidget {
  const HomeAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(FadePageRoute(widget: HomeAvatarBig()));
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(488),
              child: Image.asset(
                "assets/background/background-7.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(children: [
              SizedBox(
                width: ScreenUtil().setWidth(426),
                height: ScreenUtil().setHeight(44),
              ),
              Container(
                width: ScreenUtil().setWidth(426),
                height: ScreenUtil().setHeight(426),
                child: Image.asset(
                  'assets/avatars/home.gif',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

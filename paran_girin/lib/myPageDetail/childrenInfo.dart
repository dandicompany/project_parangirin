import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/baby_info_name.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';

final String chosen = "(으)로 접속중";
final String notchosen = "(으)로 접속하기";

class ChildrenInfo extends StatefulWidget {
  @override
  _ChildrenInfoState createState() => _ChildrenInfoState();
}

class _ChildrenInfoState extends State<ChildrenInfo> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    List<String> children = fp.getUserInfo().userInDB.children;

    return Scaffold(
      appBar: BaseAppBar(
        title: "자녀 관리",
      ),
      // body: Column(      // for another type of button
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(715),
              // height: ScreenUtil().setHeight(450),
              color: AppTheme.colors.background,
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(150)),
                  itemCount: children.length + 1,
                  itemBuilder: (context, index) {
                    logger.d("index: $index");
                    if (index == 0) {
                      return SizedBox(height: ScreenUtil().setHeight(30));
                    }
                    return FutureBuilder(
                        future: fp.getFromFB('children', children[index - 1]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            logger.d(snapshot.data);

                            Child child = Child.fromJson(snapshot.data);
                            if (child == null) {
                              return SizedBox.shrink();
                            }
                            if (children[index - 1] ==
                                fp.getUserInfo().userInDB.currentChild) {
                              return ChildrenInfoLayout(
                                image: "assets/images/onboard_1.png",
                                //text: child.nickName ?? "",
                                text: "",
                                text2: chosen,
                                press: () {},
                              );
                            } else {
                              return ChildrenInfoLayout(
                                image: "assets/images/onboard_1.png",
                                //text: child.nickName ?? "",
                                text: "",
                                text2: notchosen,
                                press: () {
                                  fp.switchChild(children[index - 1]);
                                  // setState(() {});
                                },
                              );
                            }
                          } else {
                            return SizedBox.shrink();
                          }
                        });
                  },
                  separatorBuilder: (context, index) {
                    if (index == 0) return SizedBox.shrink();
                    return SizedBox(height: ScreenUtil().setHeight(8));
                  })),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => BabyInfoName()));
          //   },
          //   child: Container(
          //     width: double.infinity,
          //     height: ScreenUtil().setHeight(64),
          //     padding: EdgeInsets.symmetric(
          //       vertical: ScreenUtil().setHeight(20)
          //     ),
          //     color: Colors.white,
          //     child: Text(
          //       "자녀 추가하기",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: ScreenUtil().setSp(16)
          //       ),
          //     )
          //   ),
          // )
          Positioned(
            bottom: ScreenUtil().setHeight(50),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
              child: DefaultButton(
                  text: "자녀 추가하기",
                  isInvert: false,
                  press: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BabyInfoName()));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

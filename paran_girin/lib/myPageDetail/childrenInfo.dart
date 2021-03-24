import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout2.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/baby_info_name.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';

final String chosen = "(으)로 접속중";
final String notchosen = "(으)로 접속하기";

class childrenInfo extends StatefulWidget {
  @override
  _ChildInfoState createState() => _ChildInfoState();
}

class _ChildInfoState extends State<childrenInfo> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    List<String> children = fp.getUserInfo().userInDB.children;
    return Scaffold(
      appBar: BaseAppBar(
        title: "자녀 관리",
      ),
      body: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child: ListView.separated(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(150)),
              itemCount: children.length + 1,
              itemBuilder: (context, index) {
                logger.d("index: $index");
                if (index == 0) {
                  return SizedBox(height: ScreenUtil().setHeight(30));
                }
                return FutureBuilder(
                    future: fp.getFromFB('children', children[index - 1]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        logger.d(snapshot.data);

                        Child child = Child.fromJson(snapshot.data);
                        if (child == null) {
                          return SizedBox.shrink();
                        }
                        if (children[index - 1] ==
                            fp.getUserInfo().userInDB.currentChild) {
                          return childrenInfoLayout(
                            image: "assets/images/onboard_1.png",
                            text: child.nickName ?? "",
                            text2: chosen,
                            press: () {},
                          );
                        } else {
                          return childrenInfoLayout(
                            image: "assets/images/onboard_1.png",
                            text: child.nickName ?? "",
                            text2: notchosen,
                            press: () {
                              fp.switchChild(children[index - 1]);
                              setState(() {});
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
      floatingActionButton: FloatingActionButton.extended(
        //elevation: 4.0,
        //shape: _CustomBorder(),
        //icon: const Icon(Icons.add),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        label: Text(
          '                        자녀 추가하기                        ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: ScreenUtil().setSp(16),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BabyInfoName()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

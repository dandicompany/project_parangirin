import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:paran_girin/home/sharing_my_answers.dart';
import 'package:paran_girin/theme/app_theme.dart';


class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  BaseAppBar(
      {Key key,
      this.title,
      this.showSend = false,
      this.isSend = false,
      this.onSend})
      : super(key: key);

  final String title;
  bool showSend;
  bool isSend;
  var onSend;
  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(56));
  State<StatefulWidget> createState() => _BaseAppBar();
  void updateState(bool showButton) {
    showSend = showButton;
    isSend = showButton;
  }
}

class _BaseAppBar extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.of(context).canPop()
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.colors.base1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: ScreenUtil().radius(20),
            )
          : null,
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppTheme.colors.base1,
          fontSize: ScreenUtil().setSp(16),
        ),
        textAlign: TextAlign.center,
      ),
      actions: widget.showSend
          ? [
              Center(
                child: Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(17)),
                    child: InkWell(
                      onTap: (){
                        widget.onSend();
                        showDialog(context: context,
                            builder: (BuildContext context)
                            {
                              return PopupAfterBbom(
                                  img: AssetImage("assets/popup/check.png"),
                                  text1: "성공적으로 영상을 파란기린에 보냈어요!",);
                                  //text2: "기발하고 재미있는 답변은 파란기린 어플과 SNS의 생각뽐내기에 게시될 수 있어요! 생각뽐내기에 선정되면 파란기린이 알려드릴게요");
                            });
                      } ?? () {
                      },
                      child: Text(
                        "보내기",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: widget.isSend
                              ? AppTheme.colors.primary2
                              : AppTheme.colors.base2,
                        ),
                      ),
                    )),
              )
            ]
          : [],
    );
  }
}

class PopupAfterBbom extends StatefulWidget {
  final String text1;
  final AssetImage img;

  const PopupAfterBbom({Key key, this.text1, this.img}) : super(key: key);
  @override
  _PopupAfterBbom createState() => _PopupAfterBbom();
}

class _PopupAfterBbom extends State<PopupAfterBbom> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
            width: ScreenUtil().setWidth(303),
            height: ScreenUtil().setHeight(205),
            padding: EdgeInsets.all(ScreenUtil().setWidth(18),),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: ScreenUtil().setSp(24.0),
                        width: ScreenUtil().setSp(24.0),
                        child: InkWell(
                          child: Image.asset("assets/icons/close-popup.png"),
                          onTap: (){
                            Navigator.of(context).pop();
                            },
                        ),
                      ),
                    ],
                ),
                SizedBox(height: ScreenUtil().setHeight(7)),
                Container(
                  width: ScreenUtil().setWidth(38),
                  height: ScreenUtil().setHeight(38),
                  child: Image.asset("assets/popup/check.png"),
                ),
                SizedBox(height: ScreenUtil().setHeight(15)),
                Text(
                  "성공적으로 영상을\n파란기린에 보냈어요!", 
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20), 
                    color:AppTheme.colors.base1,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center
                ),
              ],
            )
        )
      ],
    );
  }
}
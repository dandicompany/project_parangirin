import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  BaseAppBar(
      {Key key,
      this.title,
      this.showSend = false,
      this.isSend = false,
      this.onSend = null})
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
                      onTap: widget.onSend ?? () {
                        showDialog(context: context,
                            builder: (BuildContext context)
                            {
                              return PopupAfterBbom(
                                  img: AssetImage("assets/popup/check.png"),
                                  text1: "성공적으로 영상을 파란기린에 보냈어요!",
                                  text2: "기발하고 재미있는 답변은 파란기린 어플과 SNS의 생각뽐내기에 게시될 수 있어요! 생각뽐내기에 선정되면 파란기린이 알려드릴게요");
                            });
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
  final String text1, text2;
  final AssetImage img;

  const PopupAfterBbom({Key key, this.text1, this.text2, this.img}) : super(key: key);
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
            height: ScreenUtil().setHeight(247),
            //padding: EdgeInsets.only(left: 20, top:65, right:20, bottom: 20),
            // margin: EdgeInsets.only(top:45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 29,),
                Container(
                  width: ScreenUtil().setWidth(38),
                  height: ScreenUtil().setHeight(38),
                  child: Image.asset("assets/popup/check.png",fit: BoxFit.cover),
                ),
                SizedBox(height: 29),
                Text("성공적으로 영상을", style: TextStyle(fontSize: ScreenUtil().setSp(20), color:Colors.black), ),
                Text("파란기린에 보냈어요!", style: TextStyle(fontSize: ScreenUtil().setSp(20), color:Colors.black), ),
                SizedBox(height: 22,),
                Text("기발하고 재미있는 답변은 파란기린 어플과 SNS의 생각 ", style: TextStyle(fontSize: ScreenUtil().setSp(12), color:AppTheme.colors.base3,)),
                Text("뽐내기에 게시될 수 있이요! 생각뽐내기에 선정되면 파란 ", style: TextStyle(fontSize: ScreenUtil().setSp(12), color:AppTheme.colors.base3,)),
                Text("기린이 알려드릴게요", style: TextStyle(fontSize: ScreenUtil().setSp(12), color:AppTheme.colors.base3,)),
              ],
            )
        )

      ],
    );
  }
}
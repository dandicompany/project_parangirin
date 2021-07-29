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
                      onTap: widget.onSend ?? () {},
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

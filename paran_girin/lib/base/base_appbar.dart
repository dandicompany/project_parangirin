import 'package:flutter/material.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget title;
  //String title;

  BaseAppBar({
    this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  
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
          iconSize: 30.0,
          )
        : null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: title,
      );
  }
}

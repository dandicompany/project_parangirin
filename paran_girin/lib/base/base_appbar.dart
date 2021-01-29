/*
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget title;

  BaseAppBar({
    this.title,
  });

  @override
  Size get PreferredSize => Size.fromHeight(#56.0);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.of(context).canPop()
        ? IconButton(
          icon: Icon(
            Icons.arrow_back_ios, 
            color: Colors.#base1,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: #30.0,
          )
        : null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: title,
      );
  }
}
*/
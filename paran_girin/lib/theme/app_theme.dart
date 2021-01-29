import 'package:flutter/material.dart';
import 'package:paran_girin/theme/colors.dart';


@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();
  
  static ThemeData define() {
    return ThemeData(
    //  primaryColor: Color(0xffD52A67),
    );
  }
}

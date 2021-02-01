import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Paran Girin',
        theme: ThemeData(
          fontFamily: 'Noto Sans KR',
        ),
        // 여기 공부
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(), // SplashPage()
          '/login': (context) => LoginPage(),
          '/home': (context) => DefaultLayout(),
        },
      ),
    );
  }
}

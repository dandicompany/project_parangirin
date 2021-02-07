import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/question/question_page.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding/onboarding_screen.dart';

int initScreen;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

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
        initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
        routes: {
          'onboard': (context) => QuestionPage(),//OnboardingScreen(), 
          'login': (context) => LoginPage(),
          'home': (context) => DefaultLayout(), // QuestionPage(),
        },
      ),
    );
  }
}

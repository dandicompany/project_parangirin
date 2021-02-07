import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/question/question_page.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
        initialRoute: initScreen == 0 || initScreen == null ? '/onboard' : '/home',
        routes: {
          '/onboard': (context) => OnboardingScreen(), // DefaultLayout(),
          '/login': (context) => LoginPage(),
          '/home': (context) => OnboardingScreen(), // DefaultLayout(), // QuestionPage(),
        },
      ),
    );
  }
}


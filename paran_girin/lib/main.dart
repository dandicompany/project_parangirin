import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/login/auth_page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/services.dart';


int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black
  ));
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        title: "Flutter Firebase",
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () => MaterialApp(
        // for hobin
        //child: MaterialApp(               // for jiyun
        debugShowCheckedModeBanner: false,
        title: 'Paran Girin',
        theme: ThemeData(
          fontFamily: 'Noto Sans KR',
        ),
        initialRoute:
            initScreen == 0 || initScreen == null ? '/onboard' : '/home',
        routes: {
          '/home': (context) => DefaultLayout(), // , // QuestionPage(),
          '/onboard': (context) => OnboardingScreen(), // ,
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}

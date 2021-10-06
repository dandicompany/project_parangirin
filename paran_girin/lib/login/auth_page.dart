import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/main.dart';
import 'package:paran_girin/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/layout/splash.dart';
import 'package:paran_girin/login/baby_info_name.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    print("feeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    // bool check = fp.checkVerifiedUser();
    // if (false){
    if (fp.checkVerifiedUser()){
      // logger.d(check);
      // fp.signOut();
      return FutureBuilder(future: () async {
        await fp.loadStaticInfo();
        return await fp.initializeUserState();
      }(), builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        // fp.loadStaticInfo();
        // fp.initializeUserState();
        logger.d(snapshot.data);
        logger.d("user: ${fp.getUser()}");
        logger.d(fp.getUserInfo().id);
        logger.d(fp.getUser().uid);
        // if (fp.getUserInfo().userInDB.children.length == 0) {
        if (fp.getUserInfo().userInDB.children == null) {
          // Navigator.of(context).pop(); // 에러남
          // () {Navigator.pushReplacement<void, void>(
          //   context,MaterialPageRoute<void>(
          //     builder: (BuildContext context) => BabyInfoName()));
          // }
          return BabyInfoName(); 
        } else {
          // Navigator.of(context).pop();
          logger.d("Auge Page: User verified");
          // Navigator.pushReplacement<void, void>(
          //   context,MaterialPageRoute<void>(
          //     builder: (BuildContext context) => DefaultLayout()));
          return DefaultLayout();
        } 
      } else {
        return SplashScreen();
      }
    });} else {
      print("gaegegagegagaegaegeg");
      return OnboardingScreen();
    }
  }
}

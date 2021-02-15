import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_layout.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/main.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/layout/splash.dart';

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
    return FutureBuilder(
        future: fp.initializeUserState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            logger.d(snapshot.data);
            logger.d("user: ${fp.getUser()}");
            if (fp.checkVerifiedUser()) {
              // Todo: check user info
              if (fp.getUserInfo().children.length == 0) {
                // return BabyInfo();
                return DefaultLayout();
              } else {
                return DefaultLayout();
              }
            } else {
              print("gaegegagegagaegaegeg");
              return LoginPage();
            }
          } else {
            return SplashScreen();
          }
        });
  }
}

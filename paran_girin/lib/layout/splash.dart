import 'package:flutter/material.dart';
import 'package:paran_girin/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: AppTheme.colors.primary1, 
              strokeWidth: 6
            ),
          ],
        ),
      ),
    );
  }
}

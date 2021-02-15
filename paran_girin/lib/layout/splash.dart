import 'package:flutter/material.dart';

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
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                backgroundColor: Colors.white, strokeWidth: 6),
            SizedBox(height: 20),
            Text('Now loading...',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(offset: Offset(4, 4), color: Colors.white10)
                    ],
                    decorationStyle: TextDecorationStyle.solid))
          ],
        ),
      ),
    );
  }
}

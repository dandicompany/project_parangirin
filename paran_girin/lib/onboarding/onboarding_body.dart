import 'package:flutter/material.dart';

class OnboardingBody extends StatefulWidget {
  @override
  _OnboardingBodyState createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.black,
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(),)
      ],
    );
  }
  
}
  
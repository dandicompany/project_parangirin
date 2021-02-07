import 'package:flutter/material.dart';
import 'package:paran_girin/onboarding/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  static String routeName = "/onboard";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBody(),
    );
  }
}
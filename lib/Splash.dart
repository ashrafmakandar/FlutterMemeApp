

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:memeapp/main.dart';
import 'package:page_transition/page_transition.dart';
void main(){
  runApp(Splash());
}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 2000,
          splash: Icons.ac_unit_sharp,
          nextScreen: Home(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.green
      )
      
    );
  }
}

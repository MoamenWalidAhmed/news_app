import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../layout/news_app/news_layout.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Lottie.network('https://assets6.lottiefiles.com/datafiles/KbKSrbWahtNPvY6/data.json'),
      nextScreen: const NewsLayout(),
      backgroundColor: Colors.white,
      duration: 2000,
      splashIconSize: 250,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:receptoria1/pages/flashscreens/screen1.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static List<Color> colorizeColors = [
    Colors.white,
    Colors.yellow.shade200,
    Colors.orange.shade300,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Screen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Flavor Bytes',
              textStyle: const TextStyle(
                fontSize: 65, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold
              ),
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}



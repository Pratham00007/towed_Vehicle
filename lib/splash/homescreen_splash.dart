import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:towedvechile/homepage.dart';
import 'package:towedvechile/registervechile.dart';

class HomescreenSplash extends StatefulWidget {
  const HomescreenSplash({super.key});
  get splash => null;

  @override
  State<HomescreenSplash> createState() => _HomescreenSplashState();
}

class _HomescreenSplashState extends State<HomescreenSplash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset("asset/lottie/namastejson.json"),
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        nextScreen: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Registervechile();
            } else {
              return ShowCaseWidget(
                builder: (context) => const VechileHomePage(),
              );
            }
          },
        ),
        splashIconSize: 700,
        backgroundColor: Colors.white,
        duration: 5000,
      ),
    );
  }
}

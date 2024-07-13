import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:towedvechile/vecdetail.dart';

class Searchsplash extends StatefulWidget {
  var lastpagesearch;
  Searchsplash({super.key , required this.lastpagesearch});
  get splash => null;

  @override
  State<Searchsplash> createState() => SearchsplashState(this.lastpagesearch);
}

class SearchsplashState extends State<Searchsplash> {
  String lastpagesearch;
  SearchsplashState(this.lastpagesearch);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column (mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset("asset/lottie/globesearch.json"),
          ),
          const Text(
            "Searching....",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      nextScreen: Vecdetail(searchedvech:lastpagesearch ,),
      splashIconSize: 700,
      backgroundColor: Colors.white,
      duration: 7000,
    );

  }
}
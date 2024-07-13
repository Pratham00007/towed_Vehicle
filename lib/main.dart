import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:towedvechile/splash/homescreen_splash.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // need to change when uplaod to playstore
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(const VechileApp());
}

class VechileApp extends StatefulWidget {
  const VechileApp({super.key});

  @override
  State<VechileApp> createState() => _VechileAppState();
}

class _VechileAppState extends State<VechileApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const HomescreenSplash(),
      title: "Where is my Vehicle",
    );
  }

}

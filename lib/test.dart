import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class internetcheck extends StatefulWidget {
  const internetcheck({super.key});

  @override
  State<internetcheck> createState() => _internetcheckState();
}

class _internetcheckState extends State<internetcheck> {
  bool isinternetconnected = true;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isinternetconnected = true;
          });

          break;
        case InternetStatus.disconnected:
          setState(() {
            isinternetconnected = false;
          });
          break;
        default:
          setState(() {
            isinternetconnected = false;
          });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                isinternetconnected ? Icon(Icons.wifi) : Icon(Icons.wifi_off)));
  }
}

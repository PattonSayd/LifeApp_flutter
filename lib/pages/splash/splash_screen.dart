import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogged();
  }

  void checkLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool("logined", false);
    bool? logined = prefs.getBool("logined");

    if (logined == null || !logined) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/pages.login", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, "/pages.main", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

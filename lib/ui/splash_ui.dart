import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {

  @override
  bool get mounted {
    if (mounted) {
      setState(() {
        SplashUI();
      });
    }
    return mounted;
  }

  @override
  void initState() {
    super.initState();
    SplashUI();
  }


  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomeUI(),
      title: new Text(labels.splash.welcome,
          style: new TextStyle(
          fontWeight:  FontWeight.bold,
          fontSize: 20.0
      ),),
      image: new Image.asset('assets/avatar/gaïmaito.jpg'),
      backgroundColor: Colors.greenAccent,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }

}
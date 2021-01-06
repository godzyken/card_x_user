import 'package:card_x_user/core/constants/app_routes.dart';
import 'package:card_x_user/localizations.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashUI extends StatefulWidget {
  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return new SplashScreen(
      seconds: 15,
      navigateAfterSeconds: AppRoutes.routes,
      title: new Text(labels.splash.welcome,
          style: new TextStyle(
          fontWeight:  FontWeight.bold,
          fontSize: 20.0
      ),),
      image: new Image.asset('assets/avatar/Gaï-sensey_400x400.jpg'),
      backgroundColor: Colors.greenAccent,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
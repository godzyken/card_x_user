import 'package:card_x_user/app/modules/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/avatar_controller.dart';

class AvatarView extends GetView<AvatarController> {
  @override
  Widget build(BuildContext context) {
    return controller.photo == null
        ? LogoGraphicHeader()
        : Hero(
        tag: controller.user,
        child: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              controller.photo
            ),
          ),
        ));
  }
}

class LogoGraphicHeader extends GetView<SettingsController> {

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/img/default.png';
    if(controller.isDarkModeOn == true) {
      _imageLogo = 'assets/img/defaultDark.png';
    }
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              _imageLogo,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }

}

import 'package:card_x_user/app/modules/avatar/controllers/avatar_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class AvatarView extends GetView<AvatarController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
      assignId: true,
      init: AvatarController(),
        builder: (_) => _.authController!.isSignIn.isTrue
        ? LogoGraphicHeader()
        : Hero(
        tag: 'user-image',
        child: CircleAvatar(
          child: ClipOval(
            child: Image.network(
                _.authController!.auth.currentUser!.photoURL!
            ),
          ),
        )));
  }
}

class LogoGraphicHeader extends GetView {

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/img/default.png';
 /*   if(SettingsController.to.isSwitcheded == true) {
      _imageLogo = 'assets/img/defaultDark.png';
    }*/
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

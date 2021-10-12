import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
          id: key,
          init: ProfileController(),
          assignId: true,
          autoRemove: true,
          builder: (_) {
            return SingleChildScrollView(
              key: key,
              controller: _.scrollController,
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.start,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: AvatarView(),
              ),
            );
          }),
    );
  }
}

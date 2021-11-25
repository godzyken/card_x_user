
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

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
          id: 'profileId',
          init: ProfileController(),
          assignId: true,
          autoRemove: true,
          builder: (_) {
            return SingleChildScrollView(
              key: key,
              controller: _.scrollController,
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.start,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                    children: [
                      AvatarView(),
                      Positioned(
                        bottom: 0,
                        right: 1,
                        child: InkWell(
                            onTap: () => _.getImage(ImageSource.camera),
                            child: buildEditIcon(_.color)),
                      ),
                    ],
                  ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.authController!.auth.signOut(),
        child: Icon(Icons.logout),
      ),
    );
  }

  Widget buildEditIcon(Color? color) => buildCircle(
      child: buildCircle(
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 12,
          ),
          all: 2,
          color: color),
      all: 3,
      color: Colors.transparent);

  Widget buildCircle({
    required Widget child,
    required double all,
    Color? color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

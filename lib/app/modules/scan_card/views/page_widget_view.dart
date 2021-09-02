import 'dart:io';
import 'dart:typed_data';

import 'package:card_x_user/app/modules/scan_card/controllers/page_widget_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scanbot_sdk/scanbot_encryption_handler.dart';

class PageWidgetView extends GetView<PageWidgetController> {
  PageWidgetView(Uri? path);

  @override
  Widget build(BuildContext context) {
    var file = File.fromUri(controller.path);
    var bytes = file.readAsBytesSync();
    // var image = Image.file(file,
    // height: double.infinity, width: double.infinity,);

    final image = Image.memory(bytes);
    return Container(
      child: Center(child: image,),
    );
  }
}

class EncryptedPageWidget extends GetView<PageWidgetController> {
  EncryptedPageWidget(Uri? path);

  @override
  Widget build(BuildContext context) {
    final imageData = ScanbotEncryptionHandler.getDecryptedDataFromFile(
        controller.path);

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GetBuilder(
        didUpdateWidget: (oldWidget, state) => imageData,
        builder: (AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.data != null) {
            final image = Image.memory(snapshot.data!);
            return Center(child: image,);
          } else {
            return Container();
          }
        },),
    );
  }

}
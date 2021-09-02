import 'dart:io';

import 'package:card_x_user/app/modules/scan_card/controllers/barcode_pre_controller.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_widget_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';

import '../../../../main.dart';

class BarcodePreView extends GetView<BarcodePreController> {
  BarcodePreView(BarcodeScanningResult? result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodePreView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          getImageContainer(controller.preview!.barcodeImageURI),
          Expanded(child: ListView.builder(
              itemBuilder: (context, position) {
                return BarcodeItemWidget();
              }
          )),
        ],
      ),
    );
  }

  Widget getImageContainer(Uri? imageURI) {
    if (imageURI == null) {
      return Container();
    }

    var file = File.fromUri(imageURI);
    if (file.existsSync() == true) {
      if (controller.shouldInitWithEncryption) {
        return Container(
          height: 200,
          child: EncryptedPageWidget(imageURI),
        );
      } else {
        return Container(
          height: 200,
          child: PageWidgetView(imageURI),
        );
      }
    }
    return Container();
  }
}

class BarcodeItemWidget extends GetView<BarcodePreController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.barcodeFormatEnumMap[controller.item!.barcodeFormat] ?? 'UNKNOWN',
              style: TextStyle(
                inherit: true,
                color: Colors.black
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.item!.text ?? '',
              style: TextStyle(
                inherit: true,
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }

}

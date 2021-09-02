import 'package:card_x_user/app/modules/scan_card/controllers/page_operations_controller.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_widget_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scanbot_sdk/common_data.dart' as c;


class PageOperationsView extends GetView<PageOperationsController> {
  PageOperationsView(c.Page? page);

  @override
  Widget build(BuildContext context) {
    Widget pageView;
    if (controller.shouldInitWithEncryption) {
      pageView = EncryptedPageWidget(controller.page.documentImageFileUri!);
    } else {
      pageView = PageWidgetView(controller.page.documentImageFileUri!);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Image Preview',
          style: TextStyle(inherit: true, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                controller.estimateBlurriness(controller.page);
              },
              child: Icon(
                Icons.image_search,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(child: pageView))),
          BottomAppBar(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    controller.startCroppingScreen(controller.page);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.crop),
                      Container(width: 4),
                      Text(
                        'Crop & Rotate',
                        style: TextStyle(inherit: true, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.showFilterPage(controller.page);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.filter),
                      Container(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(inherit: true, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.deletePage(controller.page);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete, color: Colors.red),
                      Container(width: 4),
                      Text(
                        'Delete',
                        style: TextStyle(inherit: true, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

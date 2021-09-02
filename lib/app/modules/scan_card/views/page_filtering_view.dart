import 'package:card_x_user/app/modules/scan_card/controllers/page_filtering_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scanbot_sdk/common_data.dart' as c;

class PageFilteringView extends GetView<PageFilteringController> {
  PageFilteringView(c.Page? page);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageFilteringView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PageFilteringView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

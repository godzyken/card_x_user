import 'package:card_x_user/app/modules/scan_card/views/filter_preview_widget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:scanbot_sdk/common_data.dart' as c;

class PageFilteringController extends GetxController {
  //TODO: Implement PageFilteringController

  late final c.Page? _page;
  var page = "page filtering".obs;
  @override
  void onInit() {
    _page = c.Page(page.value);
    imageCache?.clearLiveImages();

    var filterPreviewWidget = FilterPreviewWidgetView(_page);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


}

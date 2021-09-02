import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/scan_card/utils/progress_dialog.dart';
import 'package:card_x_user/app/modules/scan_card/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';

class FilterAllPageController extends GetxController {
  PageRepository? pageRepository;
  ImageFilterType? selectedFilter;
  var context = Get.context;

  ImageFilterType? get imageFilterType => selectedFilter;

  @override
  void onInit() {
    imageCache?.clear();
    applyFilter();
    super.onInit();
  }

  @override
  void onReady() {
    changeSelectedFilter(imageFilterType);
    super.onReady();
  }

  @override
  void onClose() {}

  void changeSelectedFilter(ImageFilterType? imageFilterType) {
    selectedFilter = imageFilterType;
  }

  void applyFilter() async {
    await filterPages(selectedFilter!);
  }

  Future<void> filterPages(ImageFilterType filterType) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Processing ...');
    dialog.show();
    final futures = pageRepository!.pages
        .map((page) => ScanbotSdk.applyImageFilter(page, filterType));

    try {
      final pages = await Future.wait(futures);
      pages.forEach((page) {
        pageRepository!.updatePage(page);
      });
    } catch (e) {
      print(e);
    }
    await dialog.hide();
    Get.to(context, popGesture: true);
  }

}

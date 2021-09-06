import 'package:card_x_user/app/modules/scan_card/controllers/scan_card_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/scan_card/utils/utils.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_filtering_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';


class PageOperationsController extends GetxController {
  static final PageOperationsController to = Get.find();

  final _pageRepository = PageRepository();
  late final c.Page? _page;

  get page => _page;

  final context = Get.context;

  final shouldInitWithEncryption = ScanCardController().shouldInitWithEncryption;


  @override
  void onInit() {
    shouldInitWithEncryption;

    _page;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> _updatePage(c.Page page) async {
    imageCache?.clear();
    await _pageRepository.updatePage(page);
    _page = page;
  }

  Future<void> showFilterPage(c.Page page) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final resultPage = await Get.toNamed('/page-filtering', arguments: page);
    if (resultPage != null) {
      await _updatePage(resultPage);
    }
  }

  Future<void> deletePage(c.Page page) async {
    try {
      await ScanbotSdk.deletePage(page);
      await _pageRepository.removePage(page);
      Get.defaultPopGesture;
    } catch (e) {
      print(e);
    }
  }

  Future<void> startCroppingScreen(c.Page page) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    try {
      final config = CroppingScreenConfiguration(
        bottomBarBackgroundColor: Colors.blue,
        // polygonColor: Colors.yellow,
        // polygonLineWidth: 10,
        cancelButtonTitle: 'Cancel',
        doneButtonTitle: 'Save',
        // See further configs ...
      );
      final result = await ScanbotSdkUi.startCroppingScreen(page, config);
      if (isOperationSuccessful(result) && result.page != null) {
        await _updatePage(result.page!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> estimateBlurriness(c.Page page) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }
    try {
      final result = await ScanbotSdk.estimateBlurOnPage(page);

      await showAlertDialog(
        context!,
        'Blur value is :${result.toStringAsFixed(2)} ',
        title: 'Result',
      );
    } catch (e) {
      Logger.root.severe(e);
    }
  }
}

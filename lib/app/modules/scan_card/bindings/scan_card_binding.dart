import 'package:get/get.dart';

import 'package:card_x_user/app/modules/scan_card/controllers/barcode_pre_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/document_pre_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/filter_all_page_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/filter_preview_widget_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/menu_item_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/page_filtering_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/page_operations_controller.dart';
import 'package:card_x_user/app/modules/scan_card/controllers/page_widget_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';

import '../controllers/scan_card_controller.dart';

class ScanCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentPreController>(
      () => DocumentPreController(),
    );
    Get.lazyPut<FilterAllPageController>(
      () => FilterAllPageController(),
    );
    Get.lazyPut<FilterPreviewWidgetController>(
      () => FilterPreviewWidgetController(),
    );
    Get.lazyPut<PageFilteringController>(
      () => PageFilteringController(),
    );
    Get.lazyPut<PageOperationsController>(
      () => PageOperationsController(),
    );
    Get.lazyPut<MenuItemController>(
      () => MenuItemController(),
    );
    Get.lazyPut<PageWidgetController>(
      () => PageWidgetController(),
    );
    Get.lazyPut<BarcodePreController>(
      () => BarcodePreController(),
    );
    Get.lazyPut<ScanCardController>(
      () => ScanCardController(),
    );
    Get.lazyPut<MyPref>(
      () => MyPref(),
    );
  }
}

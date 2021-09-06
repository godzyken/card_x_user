import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/scan_card/utils/progress_dialog.dart';
import 'package:card_x_user/app/modules/scan_card/utils/utils.dart';
import 'package:get/get.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/scanbot_encryption_handler.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';

class FilterPreviewWidgetController extends GetxController {
  c.Page? page;
  Uri? filteredImageUri;
  c.ImageFilterType? selectedFilter;
  var context = Get.context;

  late final imageData;

  @override
  void onInit() {
    imageData =
        ScanbotEncryptionHandler.getDecryptedDataFromFile(filteredImageUri!);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void applyFilter() async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Processing');
    dialog.show();

    try {
      final updatedPage = PageRepository()
          .pages
          .map((page) => ScanbotSdk.applyImageFilter(page, selectedFilter!));
      await dialog.hide();
      Get.back(result: updatedPage, canPop: true);
    } catch (e) {
      await dialog.hide();
      print(e);
    }
  }

  Future<void> previewFilter(c.Page? page, c.ImageFilterType filterType) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    try {
      final uri =
          await ScanbotSdk.getFilteredDocumentPreviewUri(page!, filterType);

      selectedFilter = filterType;
      filteredImageUri = uri;
    } catch (e) {
      print(e);
    }
  }
}

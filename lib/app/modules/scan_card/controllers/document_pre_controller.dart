import 'package:card_x_user/app/modules/scan_card/controllers/scan_card_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/scan_card/utils/progress_dialog.dart';
import 'package:card_x_user/app/modules/scan_card/utils/utils.dart';
import 'package:card_x_user/app/modules/scan_card/views/filter_all_page_view.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/create_tiff_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/ocr_data.dart';
import 'package:scanbot_sdk/render_pdf_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

class DocumentPreController extends GetxController {
  static DocumentPreController? get to => Get.find();

  final PageRepository _pageRepository = PageRepository();
  late List<c.Page> pages;
  late bool shouldInitWithEncryption;
  var context = Get.context;

  @override
  void onInit() {
    shouldInitWithEncryption = ScanCardController().shouldInitWithEncryption;
    pages = _pageRepository.pages;
    super.onInit();
  }

  @override
  void onReady() {
    context!.owner;
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> showOperationsPage(c.Page? page) async {
    await Get.toNamed('/page-operation', arguments: page);
    update();
  }

  Future<void> startDocumentScanning() async {
    if (checkLicenseStatus(context!) == null) {
      return;
    }

    DocumentScanningResult? result;
    try {
      var config = DocumentScannerConfiguration(
        orientationLockMode: c.CameraOrientationMode.PORTRAIT,
        cameraPreviewMode: c.CameraPreviewMode.FIT_IN,
        ignoreBadAspectRatio: true,
        multiPageEnabled: false,
        multiPageButtonHidden: true,
      );
      result = await ScanbotSdkUi.startDocumentScanner(config);
    } catch (e) {
      print(e);
    }
    if (result != null) {
      if (isOperationSuccessful(result)) {
        await _pageRepository.addPages(result.pages);
        update();
      }
    }
  }

  Future<void> filterAllPages() async {
    if (!await _checkHasPages(context)) {
      return;
    }
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    await  Get.to(() => FilterAllPageView(_pageRepository));
  }

  Future<void> cleanupStorage() async {
    try {
      await ScanbotSdk.cleanupStorage();
      await _pageRepository.clearPages();
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createPdf() async {
    if (!await _checkHasPages(context)) {
      return;
    }
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Creating PDF ...');
    try {
      dialog.show();
      var options = PdfRenderingOptions(PdfRenderSize.FIXED_A4);
      final pdfFileUri =
      await ScanbotSdk.createPdf(_pageRepository.pages, options);
      await dialog.hide();
      await showAlertDialog(context!, pdfFileUri.toString(),
          title: 'PDF file URI');
    } catch (e) {
      print(e);
      await dialog.hide();
    }
  }

  Future<void> importImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await _createPage(Uri.file(image?.path ?? ''));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _createPage(Uri uri) async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    var dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Processing ...');
    dialog.show();
    try {
      var page = await ScanbotSdk.createPage(uri, false);
      page = await ScanbotSdk.detectDocument(page);
      await dialog.hide();
      await _pageRepository.addPage(page);
      update();
    } catch (e) {
      print(e);
      await dialog.hide();
    }
  }

  Future<void> createTiff(bool binarized) async {
    if (!await _checkHasPages(context)) {
      return;
    }
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Creating TIFF ...');
    dialog.show();
    try {
      var options = TiffCreationOptions(
          binarized: binarized,
          dpi: 200,
          compression: (binarized
              ? TiffCompression.CCITT_T6
              : TiffCompression.ADOBE_DEFLATE));
      final tiffFileUri =
      await ScanbotSdk.createTiff(_pageRepository.pages, options);
      await dialog.hide();
      await showAlertDialog(context!, tiffFileUri.toString(),
          title: 'TIFF file URI');
    } catch (e) {
      print(e);
      await dialog.hide();
    }
  }

  Future<void> performOcr() async {
    if (!await _checkHasPages(context)) {
      return;
    }
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    final dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Performing OCR ...');
    dialog.show();
    try {
      final result = await ScanbotSdk.performOcr(pages,
          OcrOptions(languages: ['en', 'de'], shouldGeneratePdf: false));
      await dialog.hide();
      await showAlertDialog(
          context!, 'Plain text:\n' + (result.plainText ?? ''));
    } catch (e) {
      print(e);
      await dialog.hide();
    }
  }

  Future<void> createOcrPdf() async {
    if (!await _checkHasPages(context)) {
      return;
    }
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    var dialog = ProgressDialog(context!,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Performing OCR with PDF ...');
    dialog.show();
    try {
      var result = await ScanbotSdk.performOcr(
          pages, OcrOptions(languages: ['en', 'de'], shouldGeneratePdf: true));
      await dialog.hide();
      await showAlertDialog(
          context!,
          'PDF File URI:\n' +
              (result.pdfFileUri ?? '') +
              '\n\nPlain text:\n' +
              (result.plainText ?? ''));
    } catch (e) {
      print(e);
      await dialog.hide();
    }
  }

  Future<bool> _checkHasPages(context) async {
    if (pages.isNotEmpty) {
      return true;
    }
    await showAlertDialog(context,
        'Please scan or import some documents to perform this function.',
        title: 'Info');
    return false;
  }

}

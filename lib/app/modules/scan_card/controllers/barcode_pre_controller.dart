import 'package:card_x_user/app/modules/scan_card/controllers/scan_card_controller.dart';
import 'package:get/get.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';

class BarcodePreController extends GetxController {
  static final BarcodePreController to = Get.find();

  late final BarcodeScanningResult? preview;
  late final BarcodeItem? item;

  late final Uri? imageUri;

  final scancardController = ScanCardController();

  late bool shouldInitWithEncryption;

  final barcodeFormatEnumMap = {
    BarcodeFormat.AZTEC: 'AZTEC',
    BarcodeFormat.CODABAR: 'CODABAR',
    BarcodeFormat.CODE_39: 'CODE_39',
    BarcodeFormat.CODE_93: 'CODE_93',
    BarcodeFormat.CODE_128: 'CODE_128',
    BarcodeFormat.DATA_MATRIX: 'DATA_MATRIX',
    BarcodeFormat.EAN_8: 'EAN_8',
    BarcodeFormat.EAN_13: 'EAN_13',
    BarcodeFormat.ITF: 'ITF',
    BarcodeFormat.PDF_417: 'PDF_417',
    BarcodeFormat.QR_CODE: 'QR_CODE',
    BarcodeFormat.RSS_14: 'RSS_14',
    BarcodeFormat.RSS_EXPANDED: 'RSS_EXPANDED',
    BarcodeFormat.UPC_A: 'UPC_A',
    BarcodeFormat.UPC_E: 'UPC_E',
    BarcodeFormat.MSI_PLESSEY: 'MSI_PLESSEY',
    BarcodeFormat.UNKNOWN: 'UNKNOWN',
  };


  @override
  void onInit() {
    shouldInitWithEncryption = scancardController.shouldInitWithEncryption;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}



}

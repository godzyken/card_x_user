import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:card_x_user/app/modules/scan_card/utils/license.dart';
import 'package:card_x_user/app/modules/scan_card/utils/progress_dialog.dart';
import 'package:card_x_user/app/modules/scan_card/utils/utils.dart';
import 'package:card_x_user/app/modules/scan_card/views/barcode_pre_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:getxfire/getxfire.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/ehic_scanning_data.dart';
import 'package:scanbot_sdk/license_plate_scan_data.dart';
import 'package:scanbot_sdk/mrz_scanning_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

class ScanCardController extends GetxController {
  static final ScanCardController to = Get.find();
  Image? currentPreviewImage;
  final _pageRepository = PageRepository();
  List<c.Page?>? pages;
  Uri? path;

  get context => Get.context;
  var shouldInitWithEncryption = false;

  get customStorageBaseDirectory => getDemoStorageBaseDirectory();

  get encryptionParams => getEncryptionParams();

  get loading => RxStatus.loading();

  get success => RxStatus.success();

  get empty => RxStatus.empty();

  get error => RxStatus.error('message');

  void onUpdate() async {
    try {
      var config = ScanbotSdkConfig(
          loggingEnabled: true,
          licenseKey: licenseKey,
          imageFormat: c.ImageFormat.JPG,
          imageQuality: 80,
          storageBaseDirectory: customStorageBaseDirectory,
          documentDetectorMode: DocumentDetectorMode.ML_BASED,
          encryptionParameters: encryptionParams);

      loading;
      await ScanbotSdk.initScanbotSdk(config);
      PageRepository().loadPages();
      shouldInitWithEncryption = true;
      success;

    } catch (e) {
      Logger.root.severe(e);
    }
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {}

  @override
  void onInit() async {

    pages = _pageRepository.pages;
    super.onInit();
  }

  @override
  void onReady() {
    onUpdate();
    super.onReady();
  }

  @override
  void onClose() {}

  void scanCard() async {
    DocumentScanningResult? result;
    try {
      var config = DocumentScannerConfiguration(
          multiPageEnabled: false,
          bottomBarBackgroundColor: Colors.blueAccent,
          cancelButtonTitle: "Cancel",
          autoSnappingEnabled: true,
          cameraPreviewMode: c.CameraPreviewMode.FIT_IN,
          orientationLockMode: c.CameraOrientationMode.PORTRAIT,
          textHintOK: "Perfect, don't move...");

      result = await ScanbotSdkUi.startDocumentScanner(config);
      if (result.operationResult == c.OperationResult.SUCCESS) {
        // get and use the scanned images as pages: result.pages[n]...
        displayPageImage(result.pages[0]);
        update();
      }
    } catch (e) {
      print(e);
    }

    if (result != null) {
      if (isOperationSuccessful(result)) {
        await _pageRepository.addPages(result.pages);
        await _gotoImagesView();
      }
    }
  }

  void displayPageImage(c.Page? page) {
    currentPreviewImage = Image.file(File.fromUri(path!));
  }

  EncryptionParameters? getEncryptionParams() {
    EncryptionParameters? encryptionParams;
    if (shouldInitWithEncryption) {
      encryptionParams = EncryptionParameters(
        password: 'password',
        mode: FileEncryptionMode.AES256,
      );
    }
    return encryptionParams;
  }

  Future<dynamic> _gotoImagesView() async {
    imageCache?.clear();
    return await Get.to('/document-preview');
  }

  Future<String> getDemoStorageBaseDirectory() async {
    final storageDirectory = Get.find<MyPref>().storageDirectory;

    return '${storageDirectory.val}';
  }

  void getOcrConfig() async {
    try {
      final result = await ScanbotSdk.getOcrConfigs();
      await showAlertDialog(context, jsonEncode(result), title: 'OCR Configs');
    } catch (e) {
      Logger.root.severe(e);
      await showAlertDialog(context, 'Error getting license status');
    }
  }

  void getLicenseStatus() async {
    try {
      final result = await ScanbotSdk.getLicenseStatus();
      await showAlertDialog(context, jsonEncode(result),
          title: 'License Status');
    } catch (e) {
      Logger.root.severe(e);
      await showAlertDialog(context, 'Error getting OCR configs');
    }
  }

  Future<void> importImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await _createPage(Uri.file(image?.path ?? ''), GetPlatform.isWindows);
      await _gotoImagesView();
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  Future<void> _createPage(Uri uri, context) async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    final dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: 'Processing');
    dialog.show();

    try {
      var page = await ScanbotSdk.createPage(uri, false);
      page = await ScanbotSdk.detectDocument(page);
      await _pageRepository.addPage(page);
    } catch (e) {
      Logger.root.severe(e);
    } finally {
      await dialog.hide();
    }
  }

  void startDocumentScanning() async {
    if (!await checkLicenseStatus(context!)) {
      return;
    }

    try {
      var config = DocumentScannerConfiguration(
        bottomBarBackgroundColor: Colors.blueAccent,
        ignoreBadAspectRatio: true,
        multiPageEnabled: false,
        maxNumberOfPages: 3,
        flashEnabled: true,
        autoSnappingSensitivity: 0.7,
        cameraPreviewMode: CameraPreviewMode.FIT_IN,
        orientationLockMode: CameraOrientationMode.PORTRAIT,
        //documentImageSizeLimit: Size(2000, 3000),
        cancelButtonTitle: 'Cancel',
        pageCounterButtonTitle: '%d Page(s)',
        textHintOK: "Perfect, don't move...",
        textHintNothingDetected: "Nothing",
        // ...
      );
      var result = await ScanbotSdkUi.startDocumentScanner(config);
      if (result.operationResult == OperationResult.SUCCESS) {
        if (isOperationSuccessful(result)) {
          await _pageRepository.addPages(result.pages);
          await _gotoImagesView();
          displayPageImage(result.pages[0]);
        }
      }
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void startBarcodeScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    try {
      var config = BarcodeScannerConfiguration(
          topBarBackgroundColor: Colors.blue,
          barcodeFormats: PredefinedBarcodes.allBarcodeTypes(),
          finderTextHint:
              'Please align any supported barcode in the frame to scan it.',
          additionalParameters: BarcodeAdditionalParameters(
            enableGS1Decoding: false,
            minimumTextLength: 10,
            maximumTextLength: 11,
            minimum1DBarcodesQuietZone: 10,
          )
          //cameraZoomFactor: 0.5,
          // ...
          );
      var result = await ScanbotSdkUi.startBarcodeScanner(config);
      await _showBarcodeScanningResult(result.operationResult, result);
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void startBatchBarcodeScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }
    try {
      var config = BatchBarcodeScannerConfiguration(
        barcodeFormatter: (item) async {
          final random = Random();
          final randomNumber = random.nextInt(4) + 2;
          await Future.delayed(Duration(seconds: randomNumber));
          return BarcodeFormattedData(
              title: item.barcodeFormat.toString(),
              subtitle: (item.text ?? '') + 'custom string');
        },
        topBarBackgroundColor: Colors.blueAccent,
        topBarButtonsColor: Colors.white70,
        cameraOverlayColor: Colors.black26,
        finderLineColor: Colors.red,
        finderTextHintColor: Colors.cyanAccent,
        cancelButtonTitle: 'Cancel',
        enableCameraButtonTitle: 'camera enable',
        enableCameraExplanationText: 'explanation text',
        finderTextHint:
            'Please align any supported barcode in the frame to scan it.',
        // clearButtonTitle: "CCCClear",
        // submitButtonTitle: "Submitt",
        barcodesCountText: '%d codes',
        fetchingStateText: 'might be not needed',
        noBarcodesTitle: 'nothing to see here',
        barcodesCountTextColor: Colors.purple,
        finderAspectRatio: FinderAspectRatio(width: 3, height: 2),
        topBarButtonsInactiveColor: Colors.orange,
        detailsActionColor: Colors.yellow,
        detailsBackgroundColor: Colors.amber,
        detailsPrimaryColor: Colors.yellowAccent,
        finderLineWidth: 7,
        successBeepEnabled: true,
        // flashEnabled: true,
        orientationLockMode: CameraOrientationMode.PORTRAIT,
        barcodeFormats: PredefinedBarcodes.allBarcodeTypes(),
        cancelButtonHidden: false,
        //cameraZoomFactor: 0.5
        /*additionalParameters: BarcodeAdditionalParameters(
          enableGS1Decoding: false,
          minimumTextLength: 10,
          maximumTextLength: 11,
          minimum1DBarcodesQuietZone: 10,
        )*/
      );

      final result = await ScanbotSdkUi.startBatchBarcodeScanner(config);
      if (result.operationResult == OperationResult.SUCCESS) {
        await Get.to(() => BarcodePreView(result));
      }
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void detectBarcodeOnImage() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      ///before processing image sdk need storage read permission
      final permissions =
          await [Permission.storage, Permission.photos].request();
      if (permissions[Permission.storage] ==
              PermissionStatus.granted || //android
          permissions[Permission.photos] == PermissionStatus.granted) {
        //ios
        var result = await ScanbotSdk.detectBarcodeFromImageFile(
            Uri.file(image?.path ?? ''), PredefinedBarcodes.allBarcodeTypes());
        if (result.operationResult == OperationResult.SUCCESS) {
          await Get.toNamed('BarcodesResultPreviewWidget',
              arguments: Get.arguments);
        }
      }
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void startLicensePlateScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }
    LicensePlateScanResult requestResult;
    try {
      var config = LicensePlateScannerConfiguration(
          topBarBackgroundColor: Colors.pink,
          topBarButtonsColor: Colors.white70,
          confirmationDialogAccentColor: Colors.green);
      requestResult = await ScanbotSdkUi.startLicensePlateScanner(config);
      if (requestResult.operationResult == OperationResult.SUCCESS) {
        showResultTextDialog(context, requestResult.rawText);
      }
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void estimateBlurriness() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      ///before processing an image the SDK need storage read permission
      var permissions = await [Permission.storage, Permission.photos].request();
      if (permissions[Permission.storage] ==
              PermissionStatus.granted || //android
          permissions[Permission.photos] == PermissionStatus.granted) {
        //ios
        var page =
            await ScanbotSdk.createPage(Uri.file(image?.path ?? ''), true);
        var result = await ScanbotSdk.estimateBlurOnPage(page);
        // set up the button
        showResultTextDialog(
            context, 'Blur value is :${result.toStringAsFixed(2)} ');
      }
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  void showResultTextDialog(context, result) {
    Widget okButton = TextButton(
      onPressed: () => Get.back(result: context, canPop: true),
      child: Text('OK'),
    );
    // set up the AlertDialog
    var alert = AlertDialog(
      title: Text('Result'),
      content: Text(result),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> startQRScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    try {
      final config = BarcodeScannerConfiguration(
        barcodeFormats: [BarcodeFormat.QR_CODE],
        finderTextHint: 'Please align a QR code in the frame to scan it.',
        /*  additionalParameters: BarcodeAdditionalParameters(
          enableGS1Decoding: false,
          minimumTextLength: 10,
          maximumTextLength: 11,
          minimum1DBarcodesQuietZone: 10,
        )*/
        // ...
      );
      final result = await ScanbotSdkUi.startBarcodeScanner(config);
      await _showBarcodeScanningResult(context, result);
    } catch (e) {
      Logger.root.severe(e);
    }
  }

  Future<void> _showBarcodeScanningResult(
      context, final BarcodeScanningResult result) async {
    if (result.operationResult == OperationResult.SUCCESS) {
      await Get.to(() => BarcodePreView(result));
    }
  }

  void startEhicScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    HealthInsuranceCardRecognitionResult? result;
    try {
      final config = HealthInsuranceScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        topBarButtonsColor: Colors.white70,
        // ...
      );
      result = await ScanbotSdkUi.startEhicScanner(config);
    } catch (e) {
      Logger.root.severe(e);
    }
    if (result != null) {
      if (isOperationSuccessful(result)) {
        var concatenate = StringBuffer();
        result.fields
            .map((field) =>
                "${field.type.toString().replaceAll("HealthInsuranceCardFieldType.", "")}:${field.value}\n")
            .forEach((s) {
          concatenate.write(s);
        });
        await showAlertDialog(context, concatenate.toString());
      }
    }
  }

  void startMRZScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    MrzScanningResult? result;
    try {
      final config = MrzScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
      );
      if (Platform.isIOS) {
        config.finderAspectRatio = FinderAspectRatio(width: 3, height: 1);
      }
      result = await ScanbotSdkUi.startMrzScanner(config);
    } catch (e) {
      Logger.root.severe(e);
    }

    if (result != null && isOperationSuccessful(result)) {
      final concatenate = StringBuffer();
      result.fields
          .map((field) =>
              "${field.name.toString().replaceAll("MRZFieldName.", "")}:${field.value}\n")
          .forEach((s) {
        concatenate.write(s);
      });
      await showAlertDialog(context, concatenate.toString());
    }
  }

  getExternalStorageDirectory() async {
    final extStorageDirectory = Get.find<MyPref>().extStorageDirectory;
    print(extStorageDirectory.defaultValue);
    return extStorageDirectory;
  }

  getApplicationDocumentsDirectory() async {
    final extStorageDirectory = Get.find<MyPref>().extStorageDirectory;
    print(extStorageDirectory.getBox);
    return extStorageDirectory;
  }
}

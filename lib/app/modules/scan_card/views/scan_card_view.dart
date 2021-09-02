import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_card_controller.dart';
import 'menu_item_view.dart';

class ScanCardView extends GetView<ScanCardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed('/home');
            },
            child: Text('OK', style: TextStyle(color: Colors.red),),
          ),
        ],
        title: Text('Scan Card View'),
        centerTitle: true,
      ),
      body: GetBuilder<ScanCardController>(
        builder:(_) => ListView(
          children: [
            TitleItemWidget("doc scan mon frere".tr),
            MenuItemView(
              onTap: () => _.startDocumentScanning(),
              startIcon: Icons.document_scanner,
              title: 'Scan documents'.tr,
            ),
            MenuItemView(
              onTap: () => _.importImage(),
              title: 'Import image',
            ),
            MenuItemView(
              // onTap: () => _.gotoImagesView(),
              title: 'View Results',
            ),
            TitleItemWidget("data inspector mon fwewe"),
            MenuItemView(
              onTap: () => _.startBarcodeScanner(),
              title: 'Scan Barcode (all formats: 1D + 2D)',
            ),
            MenuItemView(
              onTap: () => _.startQRScanner(),
              title: 'Scan QR code (QR format only)',
            ),
            MenuItemView(
              onTap: () => _.startBatchBarcodeScanner(),
              title: 'Scan Multiple Barcodes (batch mode)',
            ),
            MenuItemView(
              onTap: () => _.detectBarcodeOnImage(),
              title: 'Detect Barcodes from Still Image',
            ),
            MenuItemView(
              onTap: () => _.startMRZScanner(),
              title: 'Scan MRZ (Machine Readable Zone)',
            ),
            MenuItemView(
              onTap: () => _.startEhicScanner(),
              title: 'Scan EHIC (European Health Insurance Card)',
            ),
            MenuItemView(
              startIcon: Icons.scanner_sharp,
              onTap: () => _.startLicensePlateScanner(),
              title: 'Scan License Plate'.tr,
            ),
            TitleItemWidget("Test other SDK API method's frere"),
            MenuItemView(
              startIcon: Icons.phonelink_lock,
              onTap: () => _.getLicenseStatus(),
              title: 'get License status'.tr,
            ),
            MenuItemView(
              startIcon: Icons.settings,
              onTap: () => _.getOcrConfig(),
              title: 'OCR Configurations'.tr,
            ),
            MenuItemView(
              startIcon: Icons.developer_mode,
              // onTap: () => _.showLicensePageView(context, applicationName: 'Card_X_User'),
              title: 'Licenses'.tr,
            ),
          ],
        ),
      ),
    );
  }
}

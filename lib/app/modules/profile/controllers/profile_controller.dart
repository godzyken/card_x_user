import 'dart:io';

import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class ProfileController extends GetxController {
  static ProfileController? get to => Get.find();
  AuthController? authController;
  ScrollController? scrollController;
  UserModel? userModel;

  RxBool? get isaUser => authController!.isSignIn;
  Color? color;

  final count = 0.obs;
  final profileSet = false.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  @override
  void onInit() {
    authController = AuthController();
    userModel = Get.arguments;

    update(['profileId']);

    super.onInit();
  }

  @override
  void onReady() {
    ever(isaUser!, authController!.isSignIn,
        condition: authController!.initialized);

    update(['profileId']);

    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void getImage(ImageSource? imageSource) async {
    final pickFile = await ImagePicker().pickImage(source: imageSource!);
    if (pickFile != null) {
      selectedImagePath.value = pickFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              ' Mb';

      _savePicture(selectedImagePath.value);
    } else {
      Get.snackbar('Avatar error loading'.tr, 'No image selected'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void _savePicture(String? value) async {
    if (value != null) {
      await authController!.auth.currentUser!.updatePhotoURL(value);

      profileSet.value = true;

      update();
    }
  }
}

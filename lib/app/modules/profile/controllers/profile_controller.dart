import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  static ProfileController? get to => Get.find();
  AuthController? authController;
  ScrollController? scrollController;
  UserModel? userModel;
  late final RxList<UserModel> dataList;

  RxBool? get isaUser => authController!.isSignIn;

  final count = 0.obs;
  @override
  void onInit() {
    dataList = [UserModel()].obs;
    authController = AuthController();
    userModel = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    ever(isaUser!, authController!.isSignIn, condition: authController!.initialized );
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

}

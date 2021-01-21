import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FormXController extends GetxController {

  final jobTitle = TextEditingController().obs;
  final jobLocation = TextEditingController().obs;
  final jobAddress = TextEditingController().obs;
  final jobDesc = TextEditingController().obs;
  final jobActivitySector = TextEditingController().obs;
  final jobSchedules = TextEditingController().obs;
  final jobContact = TextEditingController().obs;
  final jobNumber = TextEditingController().obs;

  final cardUserModel = CardUserModel().obs;

  RxString errorText = RxString(null);
  RxBool jobAvailability = false.obs;
  Rx<Function> submitFunc = Rx<Function>(null);

  @override
  void onInit() {
    super.onInit();

  }

  void validations(String val) async {
    errorText.value = null;
    submitFunc.value = null;
    if (val.isNotEmpty) {
      if (lengthOk(val) && await available(val)) {
        print('All validations passed, enable submit form...');
        submitFunc.value = submitFunction();
        errorText.value = null;
      }
    }
  }

  bool lengthOk(String val, {int minLen = 3}) {
    if (val.length < minLen) {
      errorText.value = 'min. 3 chars';
      return false;
    }
    return true;
  }

  Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(Duration(seconds: 1),
            () => print('Available query returned'));
    if (val == "Sylvester") {
      errorText.value = "Name Taken";
      return false;
    }
    return true;
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${jobTitle.value} card');
      await Future.delayed(Duration(seconds: 1),
              () => print('User card created'));
      return true;
    };
  }

  addCardCompleted(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await Database().saveACard(cardUserModel.call());
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      print(error);
      rethrow;
    }
  }

  @override
  void onClose() {
    super.onClose();
    jobTitle?.value?.dispose();
    jobLocation?.value?.dispose();
    jobAddress?.value?.dispose();
    jobDesc?.value?.dispose();
    jobActivitySector?.value?.dispose();
    jobSchedules?.value?.dispose();
    jobContact?.value?.dispose();
    jobNumber?.value?.dispose();
  }
}

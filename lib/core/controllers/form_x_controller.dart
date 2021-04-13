import 'package:card_x_user/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FormXController extends GetxController {
  static FormXController to = Get.find();

  final jobTitle = TextEditingController().obs;
  final jobLocation = TextEditingController().obs;
  final jobAddress = TextEditingController().obs;
  final jobDesc = TextEditingController().obs;
  final jobActivitySector = TextEditingController().obs;
  final jobSchedules = TextEditingController().obs;
  final jobContact = TextEditingController().obs;
  final jobNumber = TextEditingController().obs;
  final jobImage = TextEditingController().obs;

  final cardUserModel = CardUserModel().obs;

  RxString errorText = RxString('');
  RxBool jobAvailability = false.obs;
  Rxn<Function?> submitFunc = Rxn<Function?>(null);

  updateTheValues() {
    cardUserModel.update((model) {
      model!.job = jobTitle.value.text;
      model.location = jobLocation.value.text;
      model.number = jobNumber.value.text;
      model.schedules = jobSchedules.value.text;
      model.contact = jobContact.value.text;
      model.description = jobDesc.value.text;
      model.activity = jobActivitySector.value.text;
      model.image = jobImage.value.text;
      model.status = jobAvailability;
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  void validations(String? val) async {
    errorText.value;
    submitFunc.value = null;
    if (val!.isNotEmpty) {
      if (lengthOk(val) && await available(val)) {
        print('All validations passed, enable submit form...');
        submitFunc.value = submitFunction();
        errorText.value;
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


  @override
  void onClose() {
    super.onClose();
    jobTitle.value.dispose();
    jobLocation.value.dispose();
    jobAddress.value.dispose();
    jobDesc.value.dispose();
    jobActivitySector.value.dispose();
    jobSchedules.value.dispose();
    jobContact.value.dispose();
    jobNumber.value.dispose();
    jobImage.value.dispose();
  }
}

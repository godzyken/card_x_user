import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class FormXController extends GetxController {

  final jobTitle = TextEditingController().obs;
  final jobLocation = TextEditingController().obs;
  final jobAddress = TextEditingController().obs;
  final jobDesc = TextEditingController().obs;
  final jobActivitySector = TextEditingController().obs;
  final jobSchedules = TextEditingController().obs;
  final jobContact = TextEditingController().obs;

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

/*  debounce(jobTitle, validations, time: Duration(milliseconds: 500));
  debounce(jobLocation, validations, time: Duration(milliseconds: 500));
  debounce(jobContact, validations, time: Duration(milliseconds: 500));
  debounce(jobAddress, validations, time: Duration(milliseconds: 500));
  debounce(jobActivitySector, validations, time: Duration(milliseconds: 500));
  debounce(jobSchedules, validations, time: Duration(milliseconds: 500));
  debounce(jobDesc, validations, time: Duration(milliseconds: 500));*/

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
  }
}

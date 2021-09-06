import 'package:get/get.dart';

import '../controllers/send_password_email_controller.dart';

class SendPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendPasswordEmailController>(
      () => SendPasswordEmailController(),
    );
  }
}

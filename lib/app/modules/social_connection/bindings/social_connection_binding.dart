import 'package:get/get.dart';

import '../controllers/social_connection_controller.dart';

class SocialConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialConnectionController>(
      () => SocialConnectionController(),
    );
  }
}

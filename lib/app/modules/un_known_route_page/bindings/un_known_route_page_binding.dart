import 'package:get/get.dart';

import '../controllers/un_known_route_page_controller.dart';

class UnKnownRoutePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnKnownRoutePageController>(
      () => UnKnownRoutePageController(),
    );
  }
}

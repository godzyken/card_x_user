
import 'package:get/get.dart';
import 'package:nv_golden/nv_golden.dart';

class WidgetWrapper extends NvWidgetWrapper {
  void withMaterialApp()=> add((child) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  ));
}
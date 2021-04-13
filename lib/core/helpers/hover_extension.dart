
import 'package:flutter/material.dart' show MouseRegion, Widget;
import 'package:get/get.dart';

extension HoverExtension on Widget {
  // Reference of the website dom...
  static final websiteBodyContainer = Get.window.document.getElementById(
    'body-container',
  );

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => websiteBodyContainer.style.cursor = 'pointer',
      onExit: (event) => websiteBodyContainer.style.cursor = 'default',
    );
  }
}
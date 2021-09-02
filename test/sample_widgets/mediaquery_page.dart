import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaQueryPage extends GetWidget {
  const MediaQueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.mediaQuery.size;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.blue,
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
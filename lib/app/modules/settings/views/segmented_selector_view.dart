import 'package:card_x_user/app/modules/settings/controllers/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SegmentedSelectorView extends GetView<SettingsController> {

  SegmentedSelectorView(
      {this.menuOptions, this.selectedOption, this.onValueChanged});

  final List<dynamic>? menuOptions;
  final String? selectedOption;
  final void Function(dynamic)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        groupValue: controller.selectedOption,
        children: Map.fromIterable(
          controller.menuOptions!,
          key: (option) => option.key,
          value: (option) =>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(option.icon),
                  SizedBox(width: 6),
                  Text(option.value),
                ],
              ),
        ),
        onValueChanged: controller.onValueChanged!);
  }

}

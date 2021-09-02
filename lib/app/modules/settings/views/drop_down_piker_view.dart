import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DropDownPikerView extends GetView {
  final List<dynamic>? menuOptions;
  final String? selectedOption;
  final void Function(String?)? onChanged;

  DropDownPikerView({this.menuOptions, this.selectedOption, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: menuOptions!.map((data) => DropdownMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(data.icon),
              SizedBox(width: 10),
              Text(data.value)
            ],
          ),
          value: data.key,
        )).toList(),
      value: selectedOption,
      onChanged: onChanged,
    );
  }
}

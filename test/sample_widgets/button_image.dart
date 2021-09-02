import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SampleImageButton extends GetWidget {

  const SampleImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/logo_small.png'),
          SizedBox(width: 10),
          Text(
            'test',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nv_golden/nv_golden/nv_golden_builder.dart';

extension ShortCuts on NvWidgetWrapper {
  void withDirectionality({TextDirection? textDirection}) => add(
        (child) => Directionality(
      textDirection: textDirection ?? TextDirection.ltr,
      child: child,
    ),
  );
}
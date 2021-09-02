import 'dart:typed_data';
import 'package:card_x_user/app/modules/scan_card/controllers/filter_preview_widget_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:scanbot_sdk/common_data.dart' as c;

class FilterPreviewWidgetView extends GetView<FilterPreviewWidgetController> {
  FilterPreviewWidgetView(c.Page? page);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterPreviewWidgetController>(builder: (_) {
      final image = FutureBuilder(
        future: _.imageData,
          builder: (context, AsyncSnapshot<Uint8List> snapshot) {
            var image = Image.memory(snapshot.data!);
            return Center(child: image,);
          }
      );
      return ListView(
        shrinkWrap: true,
        children: [
          buildContainer(image),
          Text("Select filter".tr,
          style: TextStyle(
            inherit: true,
            color: Colors.black,
            fontStyle: FontStyle.normal
          ),),
          for (var filter in c.ImageFilterType.values)
            RadioListTile(
              title: titleFromFilterType(filter),
                value: filter,
                groupValue: _.selectedFilter,
                onChanged: (value) {
                  _.previewFilter(_.page, (value as c.ImageFilterType?) ?? c.ImageFilterType.NONE);
                })
        ],
      );
    });
  }

  Container buildContainer(Widget image) {
    return Container(
      height: 400,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(child: image,),
        ),
      ),
    );
  }

  Text titleFromFilterType(c.ImageFilterType? filterType) {
    return Text(
      filterType.toString().replaceAll('ImageFilterType.', ''),
      style: TextStyle(
        inherit: true,
        color: Colors.black,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}

import 'package:card_x_user/app/modules/scan_card/controllers/filter_all_page_controller.dart';
import 'package:card_x_user/app/modules/scan_card/repository/page_repository.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scanbot_sdk/common_data.dart';

class FilterAllPageView extends GetView<FilterAllPageController> {
  FilterAllPageView(PageRepository pageRepository);

  @override
  Widget build(BuildContext context) {
    var filterPreviewWidget = FilterAllPreviewPageView(controller.pageRepository!);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => filterPreviewWidget.createElement(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('APPLY', style: TextStyle(
                  inherit: true,
                  color: Colors.black
                ),),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.black,
        title: Text('Filtering',
        style: TextStyle(
          inherit: true,
          color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: filterPreviewWidget,
    );
  }
}

class FilterAllPreviewPageView extends GetView {
  FilterAllPreviewPageView(PageRepository? pageRepository,
      {ImageFilterType? selectedFilter}) {
    selectedFilter = ImageFilterType.NONE;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
          child: Text('Select filter',
          style: TextStyle(
            inherit: true,
            color: Colors.black,
            fontStyle: FontStyle.normal
          ),),
        ),
        for (var filter in ImageFilterType.values)
          RadioListTile(
            title: titleFromFilterType(filter),
              value: filter,
              groupValue: controller.selectedFilter,
              onChanged: (value) {
                controller.changeSelectedFilter((value as ImageFilterType?) ?? ImageFilterType.NONE);
              })
      ],
    );
  }

  Text titleFromFilterType(ImageFilterType? filter) {
    return Text(
      filter.toString().replaceAll('ImageFilterType', ''),
      style: TextStyle(
          inherit: true,
          color: Colors.black,
          fontStyle: FontStyle.normal
      ),
    );
  }
}

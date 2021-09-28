import 'package:card_x_user/app/modules/pokemon_product/views/pokemon_product_view.dart';
import 'package:card_x_user/app/modules/pokemon_rarities/views/pokemon_rarities_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_set_controller.dart';

class PokemonSetView extends GetView<PokemonSetController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonSetController>(
        assignId: true,
        init: PokemonSetController(),
        builder: (_) {
          return _.cardSet?.id == null
              ? Center(child: CircularProgressIndicator())
              : cardSet(_);
        });
  }

  Card cardSet(PokemonSetController _) {
    return Card(
      semanticContainer: true,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
      margin: EdgeInsets.all(2.0),
      borderOnForeground: true,
      shadowColor: Colors.lightBlueAccent,
      elevation: 2.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            Expanded(
              flex: 1,
              child: Card(
                key: key,
                elevation: 12.0,
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                borderOnForeground: true,
                shadowColor: Colors.black12,
                child: SingleChildScrollView(
                  child: tableSet(_),
                  scrollDirection: Axis.vertical,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Table tableSet(PokemonSetController _) {
    return Table(
      border: TableBorder.all(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
        width: 1.0,
        style: BorderStyle.solid,
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(10.0),
        1: IntrinsicColumnWidth(flex: 10.0),
        2: FixedColumnWidth(16.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: FlexColumnWidth(3.0),
      children: <TableRow>[
        TableRow(
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  '${_.cardSet!.name}',
                  style: textStyleName,
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: Image.network(
                    _.cardSet!.images.logo,
                    alignment: Alignment.center,
                    scale: 0.8,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.scaleDown,
                    width: Get.size.shortestSide,
                    height: Get.size.shortestSide,
                  ),
                ),
              ),
              Container(
                height: 64,
                color: Colors.transparent,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Symbol',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: Image.network(
                    _.cardSet!.images.symbol,
                    alignment: Alignment.center,
                    scale: 0.8,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                    width: Get.size.shortestSide,
                    height: Get.size.shortestSide,
                  ),
                ),
              ),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Legalities',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: (Text(
                        '${_.cardSet!.legalities.unlimited}',
                        style: textStyleCell,
                      )))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                  height: 32,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                  child: Text(
                    'Set Total',
                    style: textStyleCell,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text(
                        '${_.cardSet!.printedTotal}',
                        style: textStyleCell,
                      ))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                  height: 32,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                  child: Text(
                    'Ptcgo Code',
                    style: textStyleCell,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text(
                        '${_.cardSet!.ptcgoCode}',
                        style: textStyleCell,
                      ))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Series',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: (Text(
                        '${_.cardSet!.series}',
                        style: textStyleCell,
                      )))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Total',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: (Text(
                        '${_.cardSet!.total}',
                        style: textStyleCell,
                      )))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Release date',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: (Text(
                        '${_.cardSet!.releaseDate}',
                        style: textStyleCell,
                      )))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(16.0),
              shape: BoxShape.rectangle,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text(
                  'Update At',
                  style: textStyleCell,
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: (Text(
                        '${_.cardSet!.updatedAt}',
                        style: textStyleCell,
                      )))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
      ],
    );
  }

  TextStyle get textStyleName {
    return TextStyle(
      color: Colors.blueAccent,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
    );
  }

  TextStyle get textStyleCell {
    return TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 16.5,
    );
  }
}

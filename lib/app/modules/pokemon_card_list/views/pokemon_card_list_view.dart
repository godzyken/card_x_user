import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

import '../controllers/pokemon_card_list_controller.dart';

class PokemonCardListView extends GetView<PokemonCardListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Card List'),
        centerTitle: true,
        toolbarOpacity: 0.8,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: Center(
          child: listBuilder,
        ),
      )),
    );
  }

  GetBuilder<PokemonCardListController> get listBuilder {
    return GetBuilder<PokemonCardListController>(
        init: PokemonCardListController(),
        initState: (state) => controller.getCardList(),
        builder: (_) => listViewBuilder(_));
  }

  ListView listViewBuilder(PokemonCardListController _) {
    return ListView.builder(
            shrinkWrap: true,
            controller: _.scroller,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            semanticChildCount: _.cardList.length,
            padding: EdgeInsets.all(0.0),
            itemCount: _.cardList.length,
            itemBuilder: (BuildContext context, int index) {
              final card = _.cardList[index];

              return buildListTile(card);
            },
          );
  }

  Card buildListTile(PokemonCard? card) {
    return Card(
      elevation: 2.0,
      color: Colors.lightBlueAccent,
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      semanticContainer: true,
      child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Wrap(
                alignment: WrapAlignment.start,
                spacing: 0.0,
                runAlignment: WrapAlignment.start,
                runSpacing: 0.5,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Image.network(
                    '${card!.images.small}'.tr,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    width: Get.mediaQuery.size.longestSide,
                    height: Get.mediaQuery.size.shortestSide,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      } else {
                        return AnimatedOpacity(
                          child: child,
                          curve: Curves.easeInCubic,
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                        );
                      }
                    },
                  ),
                  Card(
                    semanticContainer: true,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.hardEdge,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics())),
                      controller: ScrollController(
                          keepScrollOffset: true, initialScrollOffset: 0.0),
                      child: listTable(card),
                    ),
                  )
                ])
          ]),
    );
  }

  Table listTable(PokemonCard card) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(flex: 1),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(32),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: FlexColumnWidth(3.0),
      children: <TableRow>[
        TableRow(
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
            ),
            children: [
              Container(
                height: 20,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text('Name'),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    child: Text('${card.name}')),
              ),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            children: [
              Container(
                height: 32,
                color: Colors.grey,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                child: Text('Identifiant'),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    child: Text('${card.id}')),
              ),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
            ),
            children: [
              Container(
                  height: 32,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                  child: Text('Set Total')),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${card.set.total}'))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
            children: [
              Container(
                  height: 32,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                  child: Text('Evolution from')),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${card.evolvesFrom}'))),
              Container(
                height: 64,
                color: Colors.red,
              ),
            ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Artist '),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.artist}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Flavor Text '),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.flavorText}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Converted Retreat Cost'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.convertedRetreatCost}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Number'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.number}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('hp'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.hp}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Rarity'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.rarity}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Retreat Cost'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.retreatCost}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Resistances'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.resistances}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Legalities'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: (Text('${card.legalities}')))),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
        TableRow(children: [
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
            child: Text('Attacks'),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                child: listAttacks(card),
              )),
          Container(
            height: 64,
            color: Colors.red,
          ),
        ]),
      ],
    );
  }

  ListView listAttacks(PokemonCard card) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(flex: 1),
          1: FlexColumnWidth(1.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: FlexColumnWidth(3.0),
        children: <TableRow>[
          TableRow(children: [
            Container(
              height: 32,
              color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
              child: Text('${card.attacks[index].name}'),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    child: Text('${card.attacks[index].damage}'))),
          ]),
          TableRow(children: [
            Container(
              height: 32,
              color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
              child: Text('${card.attacks[index].convertedEnergyCost}'),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    child: Text('${card.attacks[index].text}'))),
          ]),
        ],
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: card.attacks.length,
      physics: CustomScrollPhysics(),
    );
  }
}

class CustomSimulation extends Simulation {
  final double initPosition;
  final double velocity;

  CustomSimulation({required this.initPosition, required this.velocity});

  @override
  double dx(double time) {
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }

  @override
  double x(double time) {
    var max =
        math.max(math.min(initPosition, 0.0), initPosition + velocity * time);

    return max;
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomSimulation(
      initPosition: position.pixels,
      velocity: velocity,
    );
  }
}

import 'package:card_x_user/app/modules/pokemon_rarities/views/pokemon_rarities_view.dart';
import 'package:card_x_user/app/modules/pokemon_set/views/pokemon_set_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_product_controller.dart';

class PokemonProductView extends GetView<PokemonProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Product'),
        centerTitle: true,
        shadowColor: Colors.black12,
        backgroundColor: Colors.black38,
        automaticallyImplyLeading: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: GetBuilder<PokemonProductController>(
        assignId: true,
        init: PokemonProductController(),
        builder: (_) {
          return _.card?.id == null ? Center(child: CircularProgressIndicator()) : Container(
            decoration: BoxDecoration(
                color: Colors.black38,
                backgroundBlendMode: BlendMode.darken,
                image: DecorationImage(
                    image: NetworkImage(_.card!.images.small, scale: 1.0))),
            padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      showCursor: false,
                      textInputAction: TextInputAction.search,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Colors.white),
                      autofocus: true,
                      maxLength: 30,
                      controller: _.cardName.value,
                      onChanged: (value) => _.getCard(value),
                      onFieldSubmitted: (value) =>
                          _.getCardName(_.cardName.value.text.capitalizeFirst),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.yellowAccent),
                        hintText: "Enter your Pokemon name",
                        filled: true,
                        fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(
                            gapPadding: 4.0,
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Expanded(
                    child: GetBuilder<PokemonProductController>(
                      assignId: true,
                      init: PokemonProductController(),
                      builder: (_) {
                        return Card(
                            key: key,
                            semanticContainer: true,
                            elevation: 12.0,
                            color: Colors.lightBlueAccent,
                            margin: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 3.0),
                            borderOnForeground: true,
                            shadowColor: Colors.black12,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    _.card!.images.large,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    width: Get.mediaQuery.size.shortestSide,
                                    height: Get.mediaQuery.size.shortestSide,
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                  SizedBox(),
                  ElevatedButton(
                      onPressed: () => Get.toNamed('/pokemon-rarities'),
                      child: Text('Catch Dem All !')),
                ],
              ),
            ),
          );
        },
      ),
      drawerEnableOpenDragGesture: true,
      drawerDragStartBehavior: DragStartBehavior.start,
      endDrawerEnableOpenDragGesture: true,
      extendBodyBehindAppBar: false,
      extendBody: true,
      endDrawer: PokemonSetView(),
      resizeToAvoidBottomInset: true,
    );
  }
}

import 'package:flutter/cupertino.dart';
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 46.0),
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
                  onChanged: (value) => controller.getCard(value),
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
                                child: Semantics(
                                  child: Image.network(
                                    _.card!.images.large,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    width: Get.mediaQuery.size.shortestSide,
                                    height: Get.mediaQuery.size.shortestSide,
                                  ),
                                  value: _.card!.id,
                                  container: true,
                                  image: true,
                                  onTap: () => Get.toNamed('/document-view'),
                                  header: true,
                                  maxValueLength: 1,
                                  checked: _.isCard,
                                  namesRoute: true,
                              )
                            )
                          ],
                        ));
                  },
                ),
              ),
              SizedBox(),
              ElevatedButton(
                  onPressed: () {
                    controller.getCard(controller.card!.id);
                  },
                  child: Text('Catch Dem All !')),
            ],
          ),
        ),
      ),
    );
  }
}

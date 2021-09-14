import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

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
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  controller: controller.cardName,
                  showCursor: false,
                  textInputAction: TextInputAction.search,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  maxLength: 6,
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
              Card(
                elevation: 12.0,
                color: Colors.lightBlueAccent,
                //margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                borderOnForeground: true,
                shadowColor: Colors.black12,
                child: Column(
                  children: [
                      Image.network(
                        controller.card!.images.small,
                        fit: BoxFit.cover,
                        width: Get.mediaQuery.size.shortestSide,
                        height: Get.mediaQuery.size.shortestSide,
                      ),
                      // title: Obx(() {
                      //   return Text('${controller.cardName}',
                      //     style: TextStyle(color: Colors.orange),);
                      // }),
                      // subtitle: Obx(() {
                      //   return Text('${controller.card!.evolvesFrom!}'.tr);
                      // }),

                  ],
                ),
              ),
              SizedBox(),
              Card(
                elevation: 12.0,
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                borderOnForeground: true,
                shadowColor: Colors.black12,
                child: GetBuilder<PokemonProductController>(
                    init: PokemonProductController(),
                    builder: (_) =>
                        ListView.builder(
                          shrinkWrap: true,
                          controller: _.scroller,
                          padding: EdgeInsets.all(8.0),
                          itemCount: _.cardList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final card = _.cardList[index];

                            return buildListTile(card);
                          },
                        )),
              ),
              ElevatedButton(
                  onPressed: () => controller.getCard(controller.card!.id),
                  child: Text('Catch Dem All !')
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(PokemonCard? card) {
    return ListTile(
      leading: Image.network(
        card!.images.small,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
      title: Text(card.name, style: TextStyle(color: Colors.orange),),
      subtitle: Text(card.evolvesFrom!.tr),
    );
  }
}

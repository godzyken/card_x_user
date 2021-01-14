import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_x_user/core/models/models.dart';


class CardDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = Get.arguments as CardUserModel;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: NetworkImage(
            // TODO: Avatar link
              "https://flagpedia.net/data/flags/normal/${name.status.toLowerCase()}.png"),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('details'.tr),
              backgroundColor: Colors.black12,
              elevation: 0,
              centerTitle: true,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${name.userModels}',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'total_confirmed'.tr,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${name.totalConfirmed}',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'total_deaths'.tr,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${name.totalDeaths}',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'total_recovered'.tr,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  '${name.totalRecovered}',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

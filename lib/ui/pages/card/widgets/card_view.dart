import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*class CardView extends GetView<CardUserController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.linearToSrgbGamma(),
            image: NetworkImage(
                "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('covid'.tr),
              backgroundColor: Colors.white10,
              elevation: 0,
              centerTitle: true,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                GetX<CardUserController>(
                  init: CardUserController(),
                  builder: (_) {
                    return Column(
                      children: [
                        Text(
                          'Card_Name: ${_.cardUsers.value.name}'.tr,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create_at_: ${_.cardUsers.value.dateCreated}.printError()'
                              .tr,
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Card_Id: ${_.cardUsers.value.id}'.tr,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Card_Status :${_.cardUsers.value.done}'.tr,
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Card_User :${_.cardUsers.value.cardUserModel}'
                              .tr,
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
                Obx(() => Text(
                      'this the status on card: ${Get.find<CardUserController>().cardUsers.value.done}',
                      style: TextStyle(fontSize: 20),
                    )),
                FlatButton(
                    onPressed: () {
                      Get.find<CardUserController>()
                          .updateTheCardUserValues(1, "", false);
                    },
                    child: Text(
                      "Change the value",
                      style: TextStyle(color: Colors.white),
                    )),
                OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3,
                  ),
                  shape: StadiumBorder(),
                  onPressed: () {
                    Get.toNamed('/Card/name');
                  },
                  child: Text(
                    'fetch_name'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )))
    );
  }
}*/

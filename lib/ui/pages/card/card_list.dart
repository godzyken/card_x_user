import 'package:card_x_user/core/controllers/auth_controller.dart';
import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/ui/pages/card/widgets/card_item.dart';
import 'package:flutter/material.dart'
    '';
import 'package:get/get.dart';
class CardList extends StatelessWidget {
  CardList({Key key}) : super(key: key);
  AuthController authController = AuthController.to;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CardController c = Get.put<CardController>(CardController());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(() => authController.user != null
            ? Text(" ${authController?.firebaseUser?.value?.email}")
            : Container()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authController.signOut();
              })
        ],
      ),
      body: Obx(() {
        if (c.isLoadingCard.value) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (c.cardUs.length == 0) {
          return Center(child: Text('Nothing to do'));
        }
        return ListView.builder(
            itemCount: c.cardUs.length,
            itemBuilder: (context, index) {
              return CardItem(c.cardUs.elementAt(index));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/add-card"),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

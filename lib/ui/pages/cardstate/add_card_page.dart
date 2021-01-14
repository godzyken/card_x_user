import 'dart:async';

import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/core/services/services.dart';
import 'package:card_x_user/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final CardController cardController = CardController.to;

  List<Assets> cards = []..length;
  List<CardModel> remoteCardModel = []..length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // saveProduct();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: cardController.titreProController,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextFormField(
              controller: cardController.dispoController,
              decoration: InputDecoration(hintText: "Disponibilité"),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: cardController.referenceController,
              decoration: InputDecoration(hintText: "reference"),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: cardController.descriptionController,
              minLines: 3,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Description",
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildGridView(),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //loadAssets();
        },
        child: Icon(
          Icons.camera_alt,
        ),
      ),
    );
  }

  Widget buildGridView() {
    if (remoteCardModel != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(remoteCardModel.length, (index) {
          Assets asset = remoteCardModel[index] as Assets;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: <Widget>[
       /*         AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),*/
                Positioned(
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.black.withOpacity(.5),
                      child: Center(
                        child: GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                remoteCardModel = remoteCardModel
                                    .where((element) =>
                                element.id != asset.obs)
                                    .toList();
                              });
                            }),
                      ),
                    ))
              ],
            ),
          );
        }),
      );
    else
      return Container(
        child: Center(
          child: Icon(
            Icons.image,
            size: 50,
            color: Colors.black,
          ),
        ),
      );
  }

/*  Future<void> loadAssets() async {
    List<Assets> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (resultList != null) {
      setState(() {
        resultList.addAll(images);
        images = resultList;
      });
    }
  }*/

/*  void saveProduct() {
    var user = AuthController.to.firebaseUser.value;
    CardUserModelService cardUserModelService = new CardUserModelService();
    Get.rawSnackbar(
      title: "Saving",
      messageText: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
    cardUserModelService
        .addOne(
      key: user.uid,
      value: cardController.dispoController.text,
      status: cardController.titreProController.text,
      icon: cardController.referenceController.text,
      date: cardController.horaireController.text,
      userModel: UserModel(),
    )
        .then((card) async {
      for (var i = 0; i < cards.length; i++) {
        var img = await saveImage(cards[i]);
        remoteCardModel.add(img);
      }

      cardUserModelService.addGallery(card.key, remoteCardModel);
      setState(() {
        remoteCardModel = [];
        cards = [];
        cardController.dispoController.clear();
        cardController.titreProController.clear();
        cardController.referenceController.clear();
        // cardController.cardUser.value.uid.;
      });
      Get.snackbar("Success", "Product saved");
    });
  }*/
}

Future<PhotoUrlModel> saveImage(Assets asset) async {
  /*ByteData byteData = await asset.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();
  var now = DateTime.now().millisecondsSinceEpoch;
  // Reference ref = FirebaseFirestore.instance.ref().child("$now.jpg");
  UploadTask uploadTask = ref.putData(imageData);
  final StreamSubscription<StorageTaskEvent> streamSubscription =
  uploadTask.snapshotEvents.listen((event) {
    // You can use this to notify yourself or your user in any kind of way.
    // For example: you could use the uploadTask.events stream in a StreamBuilder instead
    // to show your user what the current status is. In that case, you would not need to cancel any
    // subscription as StreamBuilder handles this automatically.

    // Here, every StorageTaskEvent concerning the upload is printed to the logs.
    print(
        "${(event.bytesTransferred * 100 / event.totalBytes)}%");
    print('EVENT ${event.state}');
  });
  var storageSnapshot = uploadTask.snapshot;
// Cancel your subscription when done.
  streamSubscription.cancel();
  var url = await storageSnapshot.ref.getDownloadURL();
  return PhotoUrlModel(id: "$now", url: url);*/

  return null;
}

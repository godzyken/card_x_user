import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CardProfileUser extends StatefulWidget {
  @override
  _CardProfileUserState createState() => _CardProfileUserState();
}

class _CardProfileUserState extends State<CardProfileUser> {
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType &&
        oldWidget.key == newWidget.key;
  }

  Card _cardUserModel;
  final card = CardUserModel();

  /*Future<void> uploadData() async {
    String text = 'Hello World!';
    List<int> encoded = utf8.encode(text);
    Uint8List data = Uint8List.fromList(encoded);

    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('uploads/hello-world.text');

    try {
      // Upload raw data.
      await ref.putData(data);
      // Get raw data.
      Uint8List downloadedData = await ref.getData();
      // prints -> Hello World!
      print(utf8.decode(downloadedData));
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> uploadFileWithMetadata(String filePath) async {
    File file = File(filePath);

    // Create your custom metadata.
    firebase_storage.SettableMetadata metadata =
    firebase_storage.SettableMetadata(
      cacheControl: 'max-age=60',
      customMetadata: <String, String>{
        'userId': 'ABC123',
      },
    );

    try {
      // Pass metadata to any file upload method e.g putFile.
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file, metadata);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> getMetadataExample() async {
    firebase_storage.FullMetadata metadata = await firebase_storage
        .FirebaseStorage.instance
        .ref('uploads/file-to-upload.png')
        .getMetadata();

    // As set in previous example.
    print(metadata.customMetadata['userId']);
  }

  Future<void> uploadString() async {
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/hello-world.text')
          .putString(dataUrl, format: firebase_storage.PutStringFormat.dataUrl);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future uploadCardToFirebase(BuildContext context) async {
    CardUserModel cardUser = card;
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('/card.txt');
  }

  Future<void> uploadExample() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.absolute}/file-to-upload.png';
    // ...
    // e.g. await uploadFile(filePath);
  }

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> listExample() async {
    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .list(firebase_storage.ListOptions(maxResults: 10));

    if (result.nextPageToken != null) {
      firebase_storage.ListResult additionalResults = await firebase_storage
          .FirebaseStorage.instance
          .ref()
          .list(firebase_storage.ListOptions(
        maxResults: 10,
        pageToken: result.nextPageToken,
      ));
    }
  }

  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('users/123/avatar.jpg')
        .getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<void> downloadFileExample() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/download-logo.png');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/logo.png')
          .writeToFile(downloadToFile);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> handleTaskExample1() async {
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('uploads/hello-world.txt')
        .putString('Hello World');

    try {
      // Storage tasks function as a Delegating Future so we can await them.
      firebase_storage.TaskSnapshot snapshot = await task;
      print('Uploaded ${snapshot.bytesTransferred} bytes.');
    } catch (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
    }
  }

  Future<void> handleTaskExample2(String filePath) async {
    File largeFile = File(filePath);

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('uploads/hello-world.txt')
        .putFile(largeFile);

    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      print('Upload complete.');
    } catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
    }
  }

  Future<void> handleTaskExample3(String filePath) async {
    File largeFile = File(filePath);

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('uploads/hello-world.txt')
        .putFile(largeFile);

    // Pause the upload.
    bool paused = await task.pause();
    print('paused, $paused');

    // Resume the upload.
    bool resumed = await task.resume();
    print('resumed, $resumed');

    // Cancel the upload.
    bool cancelled = await task.cancel();
    print('cancelled, $cancelled');

    // ...
  }

  Future<void> handleTaskExample4(String filePath) async {
    File largeFile = File(filePath);

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('uploads/hello-world.txt')
        .putFile(largeFile);

    // Via a Stream
    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      // Handle your snapshot events...
    }, onError: (e) {
      // Check if cancelled by checking error code.
      if (e.code == 'canceled') {
        print('The task has been canceled');
      }
      // Or, you can also check for cancellations via the final task.snapshot state.
      if (task.snapshot.state == firebase_storage.TaskState.canceled) {
        print('The task has been canceled');
      }
      // If the task failed for any other reason then state would be:
      print(firebase_storage.TaskState.error);
    });

    // Cancel the upload.
    bool cancelled = await task.cancel();
    print('cancelled? $cancelled');

    // Or a Task Future (or both).
    try {
      await task;
    } catch (e) {
      // Check if cancelled by checking error code.
      if (e.code == 'canceled') {
        print('The task has been canceled');
      }
      // Or, you can also check for cancellations via the final task.snapshot state.
      if (task.snapshot.state == firebase_storage.TaskState.canceled) {
        print('The task has been canceled');
      }
      // If the task failed for any other reason then state would be:
      print(firebase_storage.TaskState.error);
      // ...
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return GetBuilder<CardController>(
        init: CardController(),
        builder: (controller) => controller?.cardUser?.value?.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(labels?.home?.title),
                  actions: [
                    IconButton(icon: Icon(Icons.add), onPressed: () {})
                  ],
                ),
                body: Center(
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Container(
                        width: 300,
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text(
                                  'Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Show Card'),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Créer un profile'),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        )
    );
  }
}

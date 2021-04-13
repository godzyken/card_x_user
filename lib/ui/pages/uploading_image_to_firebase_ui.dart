import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:camera_deep_ar/camera_deep_ar.dart';

class UploadingImageToFirebaseUi extends StatefulWidget {
  @override
  _UploadingImageToFirebaseUiState createState() =>
      _UploadingImageToFirebaseUiState();
}

class _UploadingImageToFirebaseUiState
    extends State<UploadingImageToFirebaseUi> {
/*  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;*/
  late File _imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 100,
    );

    setState(() {
      // show(context);
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = _imageFile.path;
    Reference reference =
        FirebaseStorage.instance.ref().child('upload/$fileName');
    UploadTask uploadTask = reference.putFile(_imageFile);
    TaskSnapshot taskSnapshot = uploadTask.snapshot;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile)
                              : TextButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                // show(context),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
    // return show(context);
  }

/*  Widget show(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraDeepAr(
            cameraDeepArCallback: (c) async {
              cameraDeepArController = c;
              setState(() {});
            },
            androidLicenceKey:
                '3d3d076435e031ae846dd4f9e8a0a2804968c583b35c71351a8ab956b14578e851954ca68ef05b2a',
            onImageCaptured: (path) {
              print('Image Taken $path');
            },
            onVideoRecorded: (path) {
              print('Video Recorded @ $path');
            },
            onCameraReady: (isReady) {
              print('Camera Status $isReady');
            },
            iosLicenceKey:
                'c0ba69449d5e5374d7c9ae9b188d9c433fc6cb8a4edb1f15b234db8ce2e1028aa1b87265f85e5523',
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              //height:50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(Masks.values.length, (p) {
                        bool active = currentPage == p;
                        return GestureDetector(
                          onTap: () {
                            currentPage = p;
                            cameraDeepArController.changeMask(p);
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: active ? 40 : 50,
                            height: active ? 50 : 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: active ? Colors.green : Colors.white,
                                shape: BoxShape.circle),
                            child: Text(
                              "$p",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: active ? 16 : 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }*/

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: TextButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

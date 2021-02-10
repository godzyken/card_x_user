import 'package:card_x_user/ui/pages/conference/conference.dart';
import 'package:card_x_user/ui/pages/conference/widgets/ar_core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArCoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () => Get.to(ArCoreTest()),
            title:
                Text("Hello World", style: TextStyle(color: Colors.blueAccent)),
          ),
          ListTile(
            onTap: () => Get.to(ImageObjectScreen()),
            title: Text("Image"),
          ),
          ListTile(
            onTap: () => Get.to(AugmentedPage()),
            title: Text("AugmentedPage"),
          ),
          ListTile(
            onTap: () => Get.to(AugmentedImagesPage()),
            title: Text("AugmentedImagesPage"),
          ),
          ListTile(
            onTap: () => Get.to(AssetsObject()),
            title: Text("Custom Anchored Object with onTap"),
          ),
          ListTile(
            onTap: () => Get.to(RuntimeMaterials()),
            title: Text("Change Materials Property in runtime"),
          ),
          ListTile(
            onTap: () => Get.to(ObjectWithTextureAndRotation()),
            title: Text("Custom object with texture and rotation listener "),
          ),
          ListTile(
            onTap: () => Get.to(AutoDetectPlane()),
            title: Text("Plane detect handler"),
          ),
          ListTile(
            onTap: () => Get.to(Matrix3DRenderingPage()),
            title: Text("3D Matrix"),
          ),
          ListTile(
            onTap: () => Get.to(CustomObject()),
            title: Text("Custom sfb object"),
          ),
          ListTile(
            onTap: () => Get.to(RemoteObject()),
            title: Text("Remote object"),
          ),
          ListTile(
            onTap: () => Get.to(AugmentedFacesScreen()),
            title: Text("Augmented Faces"),
          ),
        ],
      ),
    );
  }
}

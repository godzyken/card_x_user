import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FileExplorerServices extends GetxService {
  static FileExplorerServices to = Get.find();
  AppLocalizations_Labels? labels;
  TextEditingController controller = TextEditingController();
  final firestoreUser = Rxn<UserModel>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  @override
  void onReady() async {
    ever(firestoreUser, handleAuthConnect);
    controller.addListener(() => _extension = controller.text);
    super.onReady();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  handleAuthConnect(_firebaseUser) async {

  }

  openFileExplorer() async {
    _loadingPath = true;

    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
          ? _extension!.replaceAll('', '').split(',')
            : null,
      ))
      ?.files;
    } on PlatformException catch (e) {
      print("Unsupporte operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if(_fileName != null) {
      _loadingPath = false;
      return _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    }
  }

  clearCachedFiles() async {
    FilePicker.platform.clearTemporaryFiles().then((value) => {
      value! ? 'Temporary files removed with success.' : 'Failed to clean temporary files'
    });
  }

  selectFolder() async {
    FilePicker.platform.getDirectoryPath().then((value) => {
      _directoryPath = value
    });
  }
}
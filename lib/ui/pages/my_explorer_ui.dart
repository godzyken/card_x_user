import 'dart:io';

import 'package:card_x_user/ui/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyExplorerUi extends StatefulWidget {
  @override
  _MyExplorerUiState createState() => _MyExplorerUiState();
}

class _MyExplorerUiState extends State<MyExplorerUi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  late String _path;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType? _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  List<UploadTask> _tasks = <UploadTask>[];
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() {
      _loadingPath = true;
    });
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType!,
        allowMultiple: _multiPick,
        allowedExtensions: ((_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll('', '').split(',')
            : null)!,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupporte operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  upLoadToFirebase() {
    if (_multiPick) {
      _paths!.forEach(
          (platformFile) => {upload(platformFile.path, platformFile.name)});
    } else {
      String fileName = _path.split('/').last;
      String filePath = _path;
      upload(fileName, filePath);
    }
  }

  upload(fileName, filePath) {
    _extension = fileName.toString().split('.').last;
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    final UploadTask uploadTask = storageRef.putFile(
      File(filePath),
      SettableMetadata(
        contentType: '$_pickingType/$_extension',
      ),
    );
    setState(() {
      _tasks.add(uploadTask);
    });
  }

  String _bytesTransferred(TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("My Files"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // TODO creer la fonction recherche global
              }),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButton(
                    hint: Text('LOAD PATH FROM'),
                    value: _pickingType,
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text('FROM AUDIO'),
                        value: FileType.audio,
                      ),
                      DropdownMenuItem(
                        child: Text('FROM IMAGE'),
                        value: FileType.image,
                      ),
                      DropdownMenuItem(
                        child: Text('FROM VIDEO'),
                        value: FileType.video,
                      ),
                      DropdownMenuItem(
                        child: Text('FROM MEDIA'),
                        value: FileType.media,
                      ),
                      DropdownMenuItem(
                        child: Text('FROM ANY'),
                        value: FileType.any,
                      ),
                      DropdownMenuItem(
                        child: Text('CUSTOM FORMAT'),
                        value: FileType.custom,
                      ),
                    ],
                    onChanged: (dynamic value) => setState(() {
                          _pickingType = value;
                          if (_pickingType != FileType.custom) {
                            _controller.text = _extension = '';
                          }
                        })),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 100.0),
                child: _pickingType == FileType.custom
                    ? TextFormField(
                        maxLength: 15,
                        autovalidateMode: AutovalidateMode.always,
                        controller: _controller,
                        decoration:
                            InputDecoration(labelText: 'File extension'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                      )
                    : const SizedBox(),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 200.0),
                child: SwitchListTile.adaptive(
                  title:
                      Text('Pick multiple files', textAlign: TextAlign.right),
                  onChanged: (bool value) => setState(() => _multiPick = value),
                  value: _multiPick,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          ..rotateX(0.01 * _offset.dy) // changed
                          ..rotateY(-0.01 * _offset.dx)
                          ..rotateZ(0.5 * _offset.direction), // changed
                        alignment: FractionalOffset.center,
                        child: GestureDetector(
                          onPanUpdate: (details) =>
                              setState(() => _offset += details.delta),
                          onDoubleTap: () =>
                              setState(() => _offset = Offset.zero),
                          child: IconOpenFilePicker(
                            func: _openFileExplorer,
                            text: 'Open file picker',
                          ),
                        )),
                    Transform(
                        transformHitTests: true,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateZ(0.5 * _offset.direction),
                        // changed// hanged
                        alignment: FractionalOffset.center,
                        child: GestureDetector(
                          onPanUpdate: (details) =>
                              setState(() => _offset += details.delta),
                          onDoubleTap: () =>
                              setState(() => _offset = Offset.zero),
                          child: IconPickFolder(
                            func: _selectFolder,
                            text: 'Pick folder',
                          ),
                        )),
                    Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          ..rotateX(0.01 * _offset.dy) // changed
                          ..rotateY(-0.01 * _offset.dx), // changed
                        alignment: FractionalOffset.center,
                        child: GestureDetector(
                          onPanUpdate: (details) =>
                              setState(() => _offset += details.delta),
                          onDoubleTap: () =>
                              setState(() => _offset = Offset.zero),
                          child: IconClearTempFiles(
                            func: _clearCachedFiles,
                            text: 'Clear temporary files',
                          ),
                        )),
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) => _loadingPath
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator(),
                      )
                    : _directoryPath != null
                        ? ListTile(
                            title: Text('Directory path'),
                            subtitle: Text(_directoryPath!),
                          )
                        : _paths != null
                            ? Container(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Scrollbar(
                                    child: ListView.separated(
                                  itemCount:
                                      _paths != null && _paths!.isNotEmpty
                                          ? _paths!.length
                                          : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final bool? isMultiPath =
                                        _paths != null && _paths!.isNotEmpty;
                                    final String? name = 'File $index: ' +
                                        (isMultiPath!
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...')!;
                                    final path = _paths!
                                        .map((e) => e.path)
                                        .toList()[index]
                                        .toString();

                                    return ListTile(
                                      title: Text(
                                        name!,
                                      ),
                                      subtitle: Text(path),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                )),
                              )
                            : const SizedBox(),
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.library_add),
        onPressed: () {
          // TODO creer la fonction ajouter un dossier
        },
      ),
    );
  }
}

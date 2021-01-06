import 'package:card_x_user/core/controllers/auth_controller.dart';
import 'package:card_x_user/core/services/file_explorer_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyExplorerUi extends StatefulWidget {
  @override
  _MyExplorerUiState createState() => _MyExplorerUiState();
}

class _MyExplorerUiState extends State<MyExplorerUi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

/*
  void _openFileExplorer() async {
    setState(() {
      _loadingPath = true;
    });
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll('', '')?.split(',')
            : null,
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
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }
*/

/*  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
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
  }*/

/*  @override
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
      drawer: Drawer(),
      body: ListView.builder(
        shrinkWrap: true,
        //itemCount: listItem.length,
        itemCount: 3,
        itemBuilder: (context, index) {
          // implementer la list d'objects
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Dismissible(
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ),
              ),
              key: ValueKey(index),
              child: Card(
                margin: const EdgeInsets.all(0.0),
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      //TODO implementer les routes
                    },
                    icon: Icon(Icons.check_circle_outline_outlined),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("title"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Description'),
                      Text('Date'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.library_add),
        onPressed: (){
          // TODO creer la fonction ajouter un dossier
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller?.firestoreUser?.value?.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('File Picker example app'),
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
                            onChanged: (value) => setState(() {
                                  _pickingType = value;
                                  if (_pickingType != FileType.custom) {
                                    _controller.text = _extension = '';
                                  }
                                })),
                      ),
                          ConstrainedBox(
                        constraints:
                            const BoxConstraints.tightFor(width: 100.0),
                        child: _pickingType == FileType.custom
                            ? TextFormField(
                                maxLength: 15,
                                autovalidateMode: AutovalidateMode.always,
                                controller: _controller,
                                decoration: InputDecoration(
                                    labelText: 'File extension'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.none,
                              )
                            : const SizedBox(),
                      ),
                          ConstrainedBox(
                        constraints:
                            const BoxConstraints.tightFor(width: 200.0),
                        child: SwitchListTile.adaptive(
                          title: Text('Pick multiple files',
                              textAlign: TextAlign.right),
                          onChanged: (bool value) =>
                              setState(() => _multiPick = value),
                          value: _multiPick,
                        ),
                      ),
                          Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () => Get.put(FileExplorerServices().openFileExplorer()),
                              child: Text("Open file picker"),
                            ),
                            RaisedButton(
                              onPressed: () => _selectFolder(),
                              child: Text("Pick folder"),
                            ),
                            RaisedButton(
                              onPressed: () => _clearCachedFiles(),
                              child: Text("Clear temporary files"),
                            ),
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
                                    subtitle: Text(_directoryPath),
                                  )
                                : _paths != null
                                    ? Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.50,
                                        child: Scrollbar(
                                            child: ListView.separated(
                                          itemCount: _paths != null &&
                                                  _paths.isNotEmpty
                                              ? _paths.length
                                              : 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final bool isMultiPath =
                                                _paths != null &&
                                                    _paths.isNotEmpty;
                                            final String name =
                                                'File $index: ' +
                                                    (isMultiPath
                                                        ? _paths
                                                            .map((e) => e.name)
                                                            .toList()[index]
                                                        : _fileName ?? '...');
                                            final path = _paths
                                                .map((e) => e.path)
                                                .toList()[index]
                                                .toString();

                                            return ListTile(
                                              title: Text(
                                                name,
                                              ),
                                              subtitle: Text(path),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        )),
                                      )
                                    : const SizedBox(),
                      ),
                    ],
                  ),
                    ),
                  )
              ),
            ),
    );
  }
}

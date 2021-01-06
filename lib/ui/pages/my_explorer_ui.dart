import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  }

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

  void _clearCachedFiles() {
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
  }
}

import 'package:card_x_user/app/modules/scan_card/controllers/document_pre_controller.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_widget_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DocumentPreView extends GetView<DocumentPreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Image results',
          style: TextStyle(
            inherit: true,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<DocumentPreController>(
        init: DocumentPreController(),
        assignId: true,
        builder: (_) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200),
                      itemBuilder: (context, position) {
                        Widget pageView;
                        if (_.shouldInitWithEncryption) {
                          pageView = EncryptedPageWidget(
                              _.pages[position].documentPreviewImageFileUri!);
                        } else {
                          pageView = PageWidgetView(
                              _.pages[position].documentPreviewImageFileUri!);
                        }
                        return GridTile(
                          child: GestureDetector(
                              onTap: () {
                                _.showOperationsPage(_.pages[position]);
                              },
                              child: pageView),
                        );
                      },
                      itemCount: _.pages.length),
                ),
              ),
              BottomAppBar(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        _addPageModalBottomSheet(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_circle),
                          Container(width: 4),
                          Text(
                            'Add',
                            style: TextStyle(
                              inherit: true,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.more_vert),
                          Container(width: 4),
                          Text(
                            'More',
                            style: TextStyle(
                              inherit: true,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showCleanupStorageDialog();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Container(width: 4),
                          Text(
                            'Delete All',
                            style: TextStyle(
                              inherit: true,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text('Perform OCR'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.performOcr();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text('Save as PDF'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.createPdf();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.picture_as_pdf),
                  title: Text('Save as PDF with OCR'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.createOcrPdf();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Safe as TIFF'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.createTiff(false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Save as TIFF 1-bit encoded'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.createTiff(true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Apply Image Filter on ALL pages'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.filterAllPages();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Cancel'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }

  void _addPageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.scanner),
                  title: Text('Scan Page'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.startDocumentScanning();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_size_select_actual),
                  title: Text('Import Page'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.importImage();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Cancel'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }

  void _showCleanupStorageDialog() {
    Widget text = SimpleDialogOption(
      child: Text('Delete all images and generated files (PDF, TIFF, etc)?'),
    );

    // set up the SimpleDialog
    final dialog = AlertDialog(
      title: const Text('Delete all'),
      content: text,
      contentPadding: EdgeInsets.all(0),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            controller.cleanupStorage();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {

          },
          child: Text('CANCEL'),
        ),
      ],
    );

    // show the dialog
    showDialog(
      builder: (BuildContext context) {
        return dialog;
      }, context: controller.context!,
    );
  }

}

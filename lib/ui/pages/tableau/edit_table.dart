import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:card_x_user/ui/components/custom_drawer.dart';
import 'package:card_x_user/ui/pages/tableau/widgets/card_table_wiedgets.dart';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTable extends StatefulWidget {
  final String? title;

  const EditTable({Key? key, this.title,}) : super(key: key);

  @override
  _EditTableState createState() => _EditTableState();
}

class _EditTableState extends State<EditTable> {
  final _editableKey = GlobalKey<EditableState>();

  void _addNewRow() {
    setState(() {
      _editableKey.currentState!.createRow();
    });
  }

  ///Print only edited rows.
  void _printEditedRows() {
    List editedRows = _editableKey.currentState!.editedRows;
    print(editedRows);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showDrawer: true,
      drawerChild: CustomDrawer(
        medium: DataTableConstants.medium,
        youtubeLink: DataTableConstants.youtube,
        website: DataTableConstants.website,
      ),
      enableDarkMode: true,
      titleText: DataTableConstants.dtTitle,
      child: GetBuilder<CardController>(
        init: CardController(),
        builder: (_) => InternalWidget(),
      ),
    );

   /* return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: TextButton.icon(
            onPressed: () => _addNewRow(),
            icon: Icon(Icons.add),
            label: Text(
              'Add',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: Text('Edit Table'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () => _printEditedRows(),
                child: Text('Print Edited Rows',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: Container(
          child: CustomPaginatedTable()
      ),*/
/*
      Editable(
        key: _editableKey,
        columns: <DataColumn>[
          DataColumn(
            label: Text("Job Title"),
            numeric: false,
            onSort: (i, b) {
              print('$i $b');
              setState(() {
                cardUserModel.sort((a, b) => a.job.compareTo(b.job));
              });
            },
            tooltip: 'display job Title',
          ),
          DataColumn(
            label: Text("tel"),
            numeric: true,
            onSort: (i, b) {
              print('$i $b');
            },
            tooltip: 'display telephone number',
          ),
          DataColumn(
            label: Text("Location"),
            numeric: false,
            onSort: (i, b) {
              print('$i $b');

            },
            tooltip: 'display location',
          ),
          DataColumn(
            label: Text("Status"),
            numeric: false,
            onSort: (i, b) {
              print('$i $b');
            },
            tooltip: 'display Status',
          ),
        ],
        rows: cardUserModel
            .map((card) =>
                DataRow(selected: true, onSelectChanged: (b) {}, cells: [
                  DataCell(
                    Text('${card.job}'),
                    showEditIcon: true,
                    placeholder: true,
                  ),
                  DataCell(
                    Text(card.number),
                    showEditIcon: true,
                    placeholder: true,
                  ),
                  DataCell(
                    Text(card.location),
                    showEditIcon: true,
                    placeholder: true,
                  ),
                  DataCell(
                    Text('${card.status}'),
                    showEditIcon: true,
                    placeholder: true,
                  ),
                ]))
            .toList(),
        zebraStripe: true,
        stripeColor2: Colors.grey[200],
        onRowSaved: (value) {
          print(value);
        },
        onSubmitted: (value) {
          print(value);
        },
        borderColor: Colors.blueGrey,
        showSaveIcon: true,
        saveIconColor: Colors.black,
        showCreateButton: true,
        tdPaddingTop: 0,
        tdPaddingBottom: 14,
        tdPaddingLeft: 10,
        tdPaddingRight: 8,
      ),
*/
    // );
  }
}

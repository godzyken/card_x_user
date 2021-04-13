import 'package:card_x_user/ui/components/components.dart';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<Cols>? cols;
  final List<Rows>? rows;

  const Body({Key? key, this.cols, this.rows}) : super(key: key);

  Widget bodyTable() => DataTable(
        onSelectAll: (b) {},
        sortColumnIndex: 0,
        sortAscending: true,
        columns: cols!.map((col) => DataColumn(
            label: Text('${col.cardUserModel}'),
            onSort: (columnIndex, ascending) => cols!.length,
            numeric: false,
            tooltip: 'display job title')) as List<DataColumn>,
        rows: rows!.map((e) => DataRow(
            selected: true,
            onSelectChanged: (b) {},
            cells: [DataCell(Text('${e.cardUserModel}'))])).toList(),
      );

  @override
  Widget build(BuildContext context) {
    final _editableKey = GlobalKey<EditableState>();

    return Scaffold(
      body: Editable(
        key: _editableKey,
        columns: cols!,
        rows: rows!,
        zebraStripe: true,
        stripeColor2: Colors.grey[200]!,
        onRowSaved: (value) => print(value),
        borderColor: Colors.blueGrey,
        showSaveIcon: true,
        saveIconColor: Colors.black,
        showCreateButton: true,
      ),
    );
  }
}

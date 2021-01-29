import 'package:card_x_user/ui/components/components.dart';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final _editableKey = GlobalKey<EditableState>();
  @override
  Widget build(BuildContext context) {
    final List<Cols> cols = [];
    final List<Rows> rows = [];
    return Scaffold(
      body: Editable(
        key: _editableKey,
        columns: cols,
        rows: rows,
        zebraStripe: true,
        stripeColor2: Colors.grey[200],
        onRowSaved: (value) => print(value),
        borderColor: Colors.blueGrey,
        showSaveIcon: true,
        saveIconColor: Colors.black,
        showCreateButton: true,
      ),
    );
  }
}

import 'package:card_x_user/core/models/models.dart';
import 'package:flutter/material.dart';

typedef OnRowSelect = void Function(int index);

class UserCardDataTableSource extends DataTableSource {
  UserCardDataTableSource({
    required List<CardUserModel> userData,
    this.onRowSelect,
  })  : _userData = userData,
        assert(userData != null);

  final List<CardUserModel> _userData;
  final OnRowSelect? onRowSelect;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    final _user = _userData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${_user.id}')),
        DataCell(Text('${_user.job}')),
        DataCell(Text('${_user.contact}')),
        DataCell(Text('${_user.number}')),
        DataCell(Text('${_user.location}')),
        DataCell(Text('${_user.status}')),
        DataCell(
          IconButton(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.details),
            onPressed: () => onRowSelect!(index),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;


  void sort<T>(Comparable<T> Function(CardUserModel d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
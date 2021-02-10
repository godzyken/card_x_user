import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/controllers/card_controller.dart';
import 'package:card_x_user/core/data/data_shared.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:card_x_user/ui/pages/tableau/widgets/card_table_wiedgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternalWidget extends StatelessWidget {
  const InternalWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _provider = Get.put(CardController());
    final _model = _provider.cardUserModel;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = UserCardDataTableSource(
      onRowSelect: (index) => _showDetails(context, _model[index]),
      userData: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, DataTableConstants.refresh);
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider),
      header: const Text(DataTableConstants.users),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: _provider.rowsPerPage,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    UserCardDataTableSource _src,
    CardController _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(DataTableConstants.colID),
          numeric: true,
          tooltip: DataTableConstants.colID,
          onSort: (colIndex, asc) {
            _sort<num>((user) => user.id, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colName),
          tooltip: DataTableConstants.colName,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.job, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colEmail),
          tooltip: DataTableConstants.colEmail,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.contact, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colTel),
          tooltip: DataTableConstants.colTel,
        ),
        DataColumn(
          label: Text(DataTableConstants.colLocation),
          tooltip: DataTableConstants.colLocation,
        ),
        DataColumn(
          label: Text(DataTableConstants.otherDetails),
          tooltip: DataTableConstants.otherDetails,
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(CardUserModel user) getField,
    int colIndex,
    bool asc,
    UserCardDataTableSource _src,
    CardController _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showSBar(BuildContext c, String textToShow) {
    Scaffold.of(c).showSnackBar(
      SnackBar(
        content: Text(textToShow),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  void _showDetails(BuildContext c, CardUserModel data) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails(data: data),
        ),
      );
}

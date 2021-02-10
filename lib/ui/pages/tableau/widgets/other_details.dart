import 'package:card_x_user/core/constants/constants.dart';
import 'package:card_x_user/core/models/models.dart';
import 'package:flutter/material.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  final CardUserModel data;

  Iterable<MapEntry<String, String>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    //

    final _width = MediaQuery.of(context).textScaleFactor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CloseButton(),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: _width * 0.1,
                  child: Text(_fieldValue.key),
                ),
                SizedBox(
                  width: _width * 0.1,
                  child: Text(
                    _fieldValue.value,
                    style: const TextStyle(),
                  ),
                )
              ],
            ),
          ),
        ],
      ],
    );
  }

  Map<String, String> _onGenerateFields(CardUserModel data) {
    final _fieldValues = {
      DataTableConstants.colID: data.id.toString(),
      DataTableConstants.colName: data.job,
      DataTableConstants.city: data.location.city,
      DataTableConstants.street: data.location.street,
      DataTableConstants.suite: data.location.suite,
      DataTableConstants.zipcode: data.location.zipcode,
      DataTableConstants.coords:
      '${data.location.geo.lat}, ${data.location.geo.lng}',
    };

    return _fieldValues;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';

Future<void> showAlertDialog(BuildContext context, String textToShow, {String? title}) async {
  Widget text = SimpleDialogOption(
    child: Padding(padding: const EdgeInsets.all(16.0),
    child: Text(textToShow),),
  );

  final dialog = AlertDialog(
    title: title != null ? Text(title) : null,
    content: text,
    contentPadding: EdgeInsets.all(0),
    actions: <Widget>[
      TextButton(
          onPressed: () => RoutePopDisposition.pop,
          child: Text('OK'),
      )
    ],
  );

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

Future<bool> checkLicenseStatus(BuildContext context) async {
  try{
    final result = await ScanbotSdk.getLicenseStatus();
    print(result);
    if (result.isLicenseValid) {
      return true;
    }
    await showAlertDialog(
        context, 'Scanbot SDK (trial) period or license has expired.',
        title: 'Info');
    return false;
  } catch (e) {
    Logger.root.severe(e);
    return false;
  }
}

bool isOperationSuccessful(Result? result) {
  return result!.operationResult == OperationResult.SUCCESS;
}
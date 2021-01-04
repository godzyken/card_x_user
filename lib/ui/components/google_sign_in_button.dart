import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({this.labelText, this.onPressed});

  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/img/google_logo.png"),
              height: 35.0),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    labelText.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
              )
            ],
          ),
        )
      );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconPickFolder extends StatelessWidget {
  final func;
  final String text;
  const IconPickFolder({Key key, this.func, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: BoxConstraints.expand(height: 120.0, width: 125.0),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        color: Colors.white,
        alignment: Alignment.topLeft,
        child: RaisedButton(
          padding: EdgeInsets.zero,
          color: Colors.white,
          clipBehavior: Clip.none,
          elevation: 1,
          autofocus: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child:  Icon(
            IconData(62617, fontFamily: 'MaterialIcons', matchTextDirection: true),
            size: 110.0, color: Colors.lightGreenAccent[400], semanticLabel: text,
          ),
          onPressed: func,
        ),
      ),
    );
  }
}

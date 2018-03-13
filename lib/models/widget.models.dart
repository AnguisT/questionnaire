// dart
import 'dart:io';

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.color = Colors.white,
    @required this.text,
    this.textColor = Colors.white,
    @required this.onPressed,
  }) : assert(text != null && text != '');

  String text;
  Color textColor;
  Color color;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Widget buttonAndroid = new RaisedButton(
      color: color,
      textColor: textColor,
      child: new Text(text),
      onPressed: onPressed,
    );

    Widget buttonIOS = new CupertinoButton(
      child: new Text(text, style: new TextStyle(color: textColor),),
      color: color,
      onPressed: onPressed,
    );

    return Platform.isIOS ? buttonIOS : buttonAndroid;
  }
}

class SystemPadding extends StatelessWidget {
  final Widget child;

  SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: 300),
      child: child
    );
  }
}
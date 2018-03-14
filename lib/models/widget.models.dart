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

  final String text;
  final Color textColor;
  final Color color;
  final VoidCallback onPressed;

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

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    this.title,
    @required this.content,
    @required this.onOk,
    this.onCancel
  });

  final Widget title;
  final Widget content;
  final VoidCallback onOk;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {

    // Android Alert Dialog with title and with/without cancel button
    Widget alertDialogAndroidWithCancel = new AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text('Cancel'),
          onPressed: onCancel
        ),
        new FlatButton(
          child: new Text('OK'),
          onPressed: onOk
        ),
      ],
    );

    Widget alertDialogAndroidWithoutCancel = new AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text('OK'),
          onPressed: onOk
        ),
      ],
    );

    // IOS Alert Dialog with title and with/without cancel button
    Widget alertDialogIOSWithCancel = new CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text('Cancel'),
          isDestructiveAction: true,
          onPressed: onCancel
        ),
        new CupertinoDialogAction(
          child: new Text('OK'),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );

    Widget alertDialogIOSWithoutCancel = new CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text('OK'),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );

    Widget alertDialogAndroid = (onCancel == null ? alertDialogAndroidWithoutCancel : alertDialogAndroidWithCancel);
    Widget alertDialogIOS = (onCancel == null ? alertDialogIOSWithoutCancel : alertDialogIOSWithCancel);

    return Platform.isIOS ? alertDialogIOS : alertDialogAndroid;
  }
}

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    @required this.title,
    this.centerTitle: false,
    this.hideButtonBack: false,
    this.backgroundColor,
  }) : assert(title != null);

  final Widget title;
  final Widget leading;
  final IconThemeData iconTheme;
  final Colors backgroundColor;
  final List<Widget> actions;
  final bool centerTitle;
  final bool hideButtonBack;

  @override
  Widget build(BuildContext context) {
    Widget navigationBarIOS = new CupertinoNavigationBar();

    // TODO: implement build
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
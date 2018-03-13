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

class CustomAlertDialoog extends StatelessWidget {
  CustomAlertDialoog({
    this.title,
    @required this.content,
    @required this.onOk,
    this.onCancel
  });

  final String title;
  final Widget content;
  final VoidCallback onOk;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {

    // Android Alert Dialog with title and with/without cancel button
    Widget alertDialogAndroidWithTitleWithCancel = new AlertDialog(
      title: new Text(title),
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

    Widget alertDialogAndroidWithTitleWithoutCancel = new AlertDialog(
      title: new Text(title),
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text('OK'),
          onPressed: onOk
        ),
      ],
    );

    // Android Alert Dialog with/without title and with cancel button
    Widget alertDialogAndroidWithoutTitleWithCancel = new AlertDialog(
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

    Widget alertDialogAndroidWithoutTitleWithoutCancel = new AlertDialog(
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text('OK'),
          onPressed: onOk
        ),
      ],
    );

    // IOS Alert Dialog with title and with/without cancel button
    Widget alertDialogIOSWithTitleWithCancel = new CupertinoAlertDialog(
      title: new Text(title),
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

    Widget alertDialogIOSWithTitleWithoutCancel = new CupertinoAlertDialog(
      title: new Text(title),
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text('OK'),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );

    // IOS Alert Dialog with/without title and with cancel button
    Widget alertDialogIOSWithoutTitleWithCancel = new CupertinoAlertDialog(
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: const Text('Cancel'),
          isDestructiveAction: true,
          onPressed: onCancel
        ),
        new CupertinoDialogAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );

    Widget alertDialogIOSWithoutTitleWithoutCancel = new CupertinoAlertDialog(
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );


    Widget alertDialogAndroidWithTitleWithOrWithoutButton = onCancel != null ? alertDialogAndroidWithTitleWithCancel : alertDialogAndroidWithTitleWithoutCancel;

    Widget alertDialogAndroidWithoutTitleWithOrWithoutButton = onCancel != null ? alertDialogAndroidWithoutTitleWithCancel : alertDialogAndroidWithoutTitleWithoutCancel;


    Widget alertDialogIOSWithTitleWithOrWithoutButton = onCancel != null ? alertDialogIOSWithTitleWithCancel : alertDialogIOSWithTitleWithoutCancel;

    Widget alertDialogIOSWithoutTitleWithOrWithoutButton = onCancel != null ? alertDialogIOSWithoutTitleWithCancel : alertDialogIOSWithoutTitleWithoutCancel;

    Widget alertDialogAndroid = (title == null ? alertDialogAndroidWithoutTitleWithOrWithoutButton : alertDialogAndroidWithTitleWithOrWithoutButton);
    Widget alertDialogIOS = (title == null ? alertDialogIOSWithoutTitleWithOrWithoutButton : alertDialogIOSWithTitleWithOrWithoutButton);

    return Platform.isIOS ? alertDialogIOS : alertDialogAndroid;
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
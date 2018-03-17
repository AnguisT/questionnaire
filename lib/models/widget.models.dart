// dart
import 'dart:io';

// package
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// class
import '../modules/localizations.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.color = Colors.white,
    @required this.text,
    this.textColor = Colors.white,
    @required this.onPressed,
  }) : assert(text != null && text != '');

  /// Set the text in inside button
  final String text;

  /// Set the color in inside button for [text]
  final Color textColor;

  /// Set the color for button
  final Color color;

  /// Set the function for button
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

  /// The (optional) title of the dialog is displayed at the top of the dialog.
  final Widget title;

  /// The (optional) content of the dialog is displayed in the center of the dialog.
  final Widget content;

  /// Function for button [OK]
  final VoidCallback onOk;

  /// Function for button [Cancel]
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {

    /// Android Alert Dialog with title and with cancel button
    Widget alertDialogAndroidWithCancel = new AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_cancel']),
          onPressed: onCancel
        ),
        new FlatButton(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_ok']),
          onPressed: onOk
        ),
      ],
    );

    /// Android Alert Dialog with title and without cancel button
    Widget alertDialogAndroidWithoutCancel = new AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new FlatButton(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_ok']),
          onPressed: onOk
        ),
      ],
    );

    /// IOS Alert Dialog with title and with cancel button
    Widget alertDialogIOSWithCancel = new CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_cancel']),
          isDestructiveAction: true,
          onPressed: onCancel
        ),
        new CupertinoDialogAction(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_ok']),
          isDefaultAction: true,
          onPressed: onOk
        ),
      ]
    );

    /// IOS Alert Dialog with title and without cancel button
    Widget alertDialogIOSWithoutCancel = new CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        new CupertinoDialogAction(
          child: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['btn_ok']),
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

class CustomNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  CustomNavigationBar({
    @required this.title,
    this.backgroundColor,
    this.iconTheme,
    this.leading,
    this.actionsAndroid,
    this.trailingIOS,
    this.centerTitle: false,
    this.buttonBack: true,
    this.colorButtonBackIOS: Colors.white,
  }) : assert(title != null);

  /// Widget displayed in the center app bar.
  final Widget title;

  /// Widget to display before the [title] widget.
  final Widget leading;

  /// Only IOS. Widgets to display after the [title] widget.
  final Widget trailingIOS;

  /// How will display back button
  final IconThemeData iconTheme;

  /// The color to use for the app bar.
  final Color backgroundColor;

  /// Only IOS. Set the color for the back button.
  final Color colorButtonBackIOS;

  /// Only android. Widgets to display after the [title] widget.
  final List<Widget> actionsAndroid;

  /// Will the title be in the center app bar.
  final bool centerTitle;

  /// Hide or show back button.
  final bool buttonBack;

  @override
  Widget build(BuildContext context) {
    Widget navigationBarIOS = new CupertinoNavigationBar(
      middle: title,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: buttonBack,
      leading: leading,
      trailing: trailingIOS,
      actionsForegroundColor: colorButtonBackIOS,
    );

    Widget navigationBarAndroid = new AppBar(
      title: title,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: buttonBack,
      centerTitle: centerTitle,
      leading: leading,
      actions: actionsAndroid,
      iconTheme: iconTheme,
    );

    return Platform.isIOS ? navigationBarIOS : navigationBarAndroid;
  }

  @override
  Size get preferredSize => Platform.isIOS ? const Size.fromHeight(55.0) : const Size.fromHeight(55.0);
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

class RadioInDialog extends StatefulWidget {

  @override
  _RadioInDialog createState() => new _RadioInDialog();
}

class _RadioInDialog extends State<RadioInDialog> {

  /// The currently selected value for this group of radio buttons.
  int languageVal = 1;

  @override
  Widget build(BuildContext context) {
    return new CustomAlertDialog(
      title: new Text(new DemoLocalizations().localizedValues[languageCode]['common']['change_language']['title']),
      content: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new GestureDetector(
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  children: <Widget>[
                    new Text(new DemoLocalizations().localizedValues[languageCode]['common']['change_language']['en']),
                    new Radio<int>(
                      groupValue: languageVal,
                      value: 1,
                      onChanged: (val) {
                        setState(() {
                          languageVal = val;
                        });
                      },
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  languageVal = 1;
                });
              },
            ),
            new GestureDetector(
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: new Row(
                  children: <Widget>[
                    new Text(new DemoLocalizations().localizedValues[languageCode]['common']['change_language']['ru']),
                    new Radio<int>(
                      groupValue: languageVal,
                      value: 2,
                      onChanged: (val) {
                        setState(() {
                          languageVal = val;
                        });
                      },
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  languageVal = 2;
                });
              },
            ),
          ],
        )
      ), onOk: () {
        if (languageVal == 1) {
          languageCode = 'en';
        } else {
          languageCode = 'ru';
        }
        Navigator.of(context).pop();
      },
    );
  }
}
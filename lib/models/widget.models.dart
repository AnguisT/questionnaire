// // dart
// import 'dart:io';

// // package
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class _CustomButton extends StatelessWidget {
//   _CustomButton({
//     this.inAndroid = false,
//     this.color = Colors.white,
//     this.text,
//     this.textColor = Colors.white,
//     @required this.onPressed,
//   }) : assert(text != null && text != '');

//   bool inAndroid = true;
//   String text;
//   Color textColor;
//   Color color;
//   VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     Widget buttonAndroid = new RaisedButton(
//       color: color,
//       textColor: textColor,
//       child: new Text(text),
//       onPressed: onPressed,
//     );

//     Widget buttonIOS = new CupertinoButton(
//       child: new Text(text, style: new TextStyle(color: textColor),),
//       color: color,
//       onPressed: onPressed,
//     );

//     return Platform.isIOS ? buttonIOS : buttonAndroid;
//   }

// }
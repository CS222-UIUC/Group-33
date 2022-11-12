import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> popupKey =
GlobalKey<ScaffoldMessengerState>();

enum AlertLevel {
  info,
  warning,
  error
}

const Color _infoColor = Color(0xff312c2c);
const Color _warningColor = Color(0xffb9862c);
const Color _errorColor = Color(0xffe03131);

// this is the function that we call to make a popup
// it will display the popup as soon as you call it.
void displayAlertMessage(String message, AlertLevel alertLevel){
  final Color color;
  final Color textColor;
  switch (alertLevel){
    case AlertLevel.info:
      color = _infoColor;
      textColor = const Color(0xffffffff);  // white
      break;
    case AlertLevel.warning:
      color = _warningColor;
      textColor = const Color(0xff000000);  // black
      break;
    case AlertLevel.error:
      color = _errorColor;
      textColor = const Color(0xff000000);  // black
  }

  popupKey.currentState!.showSnackBar(
    SnackBar(
        content: Text(
            message,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
    ),
  );
}

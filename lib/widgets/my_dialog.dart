import 'package:flutter/material.dart';

class MyDialog {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    int seconds = 2,
    String label = 'Dismiss',
  }) {
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(seconds: seconds),
      content: Text( message,style: TextStyle(color: Colors.black),),
      action: SnackBarAction(label: label,textColor: Colors.black, onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void circularProgressStart(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 10.0,
          ),
        );
      },
    );
  }


  static void circularProgressStop(BuildContext context) {
    Navigator.pop(context);
  }
}

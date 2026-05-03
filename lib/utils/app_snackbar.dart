import 'package:flutter/material.dart';

class AppSnackbar {
  static void snackBarMessage(BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg))
    );
  }

}
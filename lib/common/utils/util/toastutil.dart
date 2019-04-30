import 'package:flutter/material.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flushbar/flushbar.dart';

//snackbar
class ToastUtils {
  static void info(BuildContext context, String msg) {
    Flushbar(
      aroundPadding: EdgeInsets.all(8.0),
      borderRadius: 8.0,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      message: msg,
      isDismissible: true,
      boxShadow: BoxShadow(
        color: Color(0xFF303030),
        offset: Offset(0.0, 2.0),
        blurRadius: 3.0,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

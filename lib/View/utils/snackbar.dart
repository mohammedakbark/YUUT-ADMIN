import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yuut_admin/Const/colors.dart';
import 'package:yuut_admin/Const/const.dart';

// showErrorMessage(context, content) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       behavior: SnackBarBehavior.floating,
//       padding: const EdgeInsets.only(left: 8, right: 20, top: 5, bottom: 5),
//       backgroundColor: red,
//       content: Text(
//         content,
//         style: appTextstyle(letterSpacing: 1, color: black),
//       )));
// }

// showSuccessMessage(context, content) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       dismissDirection: DismissDirection.up,
//       behavior: SnackBarBehavior.floating,
//       padding: const EdgeInsets.only(left: 8, right: 20, top: 5, bottom: 5),
//       backgroundColor: green,
//       content: Text(
//         content,
//         style: appTextstyle(letterSpacing: 1, color: black),
//       )));
// }

showSuccessMessage(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: green,
      textColor: white,
      fontSize: 16.0);
}

showErrorMessage(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: red,
      textColor: white,
      fontSize: 16.0);
}

showWarningMessage(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: grey,
      textColor: black,
      fontSize: 16.0);
}

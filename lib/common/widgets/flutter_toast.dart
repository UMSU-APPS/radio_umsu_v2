import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo({
  required String msg,
  Color backgrounColor = Colors.black,
  Color textColor = Colors.white,
  Toast? toastLength = Toast.LENGTH_SHORT,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength!,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: backgrounColor,
    textColor: textColor,
    fontSize: 16.sp,
  );
}

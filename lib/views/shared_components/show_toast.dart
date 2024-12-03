import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../../util/constants/colors.dart';


void showToast(String message, Color backgroundColor) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: colorWhite,
    fontSize: 16.0,
  );
}

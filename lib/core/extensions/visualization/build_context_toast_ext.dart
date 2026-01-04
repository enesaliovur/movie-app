import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastExtension on BuildContext {
  void showFailureToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? tr.common.somethingWentWrong,
      gravity: ToastGravity.TOP,
      textColor: white,
      backgroundColor: redLight,
    );
  }
}

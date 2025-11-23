import 'package:flutter/material.dart';
import 'package:oivan_assignment/core/constants/ui_const.dart';

class AppStyle {
  static final cardStyle = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(UIConst.cardRaduis),
    side: const BorderSide(
      color: Colors.white24,
      width: 1,
    ),
  );
}

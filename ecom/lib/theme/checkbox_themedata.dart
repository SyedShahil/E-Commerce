import 'package:flutter/material.dart';

import '../constants.dart';

CheckboxThemeData checkboxThemeData = const CheckboxThemeData(
  checkColor: WidgetStatePropertyAll<Color>(Colors.white),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadious / 2),
    ),
  ),
  side: BorderSide(color: whileColor40),
);

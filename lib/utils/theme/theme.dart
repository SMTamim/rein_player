import 'package:flutter/material.dart';
import 'package:rein_player/utils/constants/rp_colors.dart';
import 'package:rein_player/utils/theme/custom/text_theme.dart';

class RpAppTheme {
  RpAppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: RpColors.gray_800,
    brightness: Brightness.dark,
    textTheme: RpTextTheme.darkTextTheme,
    scaffoldBackgroundColor: RpColors.black
  );
}
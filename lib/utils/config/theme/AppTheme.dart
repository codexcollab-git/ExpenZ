import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.indicatorColor,
      splashColor: Colors.transparent,
      fontFamily: 'RedditSans',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    );
  }
}

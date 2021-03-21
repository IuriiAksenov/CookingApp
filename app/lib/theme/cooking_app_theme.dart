import 'package:app/theme/colors.dart';
import 'package:flutter/material.dart';

class CookingAppTheme {
  static ThemeData get cookingAppTheme => _buildShrineTheme();

  static ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      //accentColor: cookingAppBrown900,
      primaryColor: cookingAppBackgroundWhite, //cookingAppPink100,
      buttonTheme: base.buttonTheme.copyWith(
        //buttonColor: cookingAppPink100,
        colorScheme: base.colorScheme.copyWith(
            //  secondary: cookingAppBrown900,
            ),
      ),
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0.0,
        textTheme: base.textTheme.copyWith(
          headline6: base.textTheme.headline6.copyWith(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      scaffoldBackgroundColor: cookingAppBackgroundWhite,
      cardColor: cookingAppBackgroundWhite,
      textSelectionColor: cookingAppPink100,
      errorColor: cookingAppErrorRed,
      textTheme: _buildCookingAppTextTheme(base.textTheme),
      primaryTextTheme: _buildCookingAppTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildCookingAppTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: cookingAppBrown900),
    );
  }

  static TextTheme _buildCookingAppTextTheme(TextTheme base) {
    return base
        .copyWith(
            // headline5: base.headline5.copyWith(
            //   fontWeight: FontWeight.w500,
            // ),
            // headline6: base.headline6.copyWith(
            //   fontSize: 36.0,
            //   fontWeight: FontWeight.bold,
            // ),
            // caption: base.caption.copyWith(
            //   fontWeight: FontWeight.w400,
            //   fontSize: 14.0,
            // ),
            // bodyText1: base.bodyText1.copyWith(
            //   fontWeight: FontWeight.w500,
            //   fontSize: 16,
            // ),
            )
        .apply(
          fontFamily: 'Roboto',
          // displayColor: cookingAppBrown900,
          // bodyColor: cookingAppBrown900,
        );
  }
}

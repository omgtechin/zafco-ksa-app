import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../../core/adaptive/adaptive.dart';
import '../../core/themes/text_style.dart';

class AppTheme {
  const AppTheme._();
  static Color lightBackgroundColor = const Color(0xffF4F5FE);
  static Color lightPrimaryColor = const Color(0xff006CEA);
  static Color lightAccentColor = const Color(0xFF097a95);
  static Color lightDividerColor = Colors.grey.shade800;

  static Color darkBackgroundColor = const Color(0xFF1A2127);
  static Color darkPrimaryColor = const Color(0xff068bf0);
  static Color darkAccentColor = const Color(0xFF097a95);
  static Color darkDividerColor = Colors.white;

  static Color priceColor = const Color(0xff219653);
  static Color xyzColor = const Color(0xffffffff);

  static final lightTheme = ThemeData(

    brightness: Brightness.light,
    textTheme: appTextTheme,

    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    backgroundColor: lightBackgroundColor,
    shadowColor: Colors.grey.shade300,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    // textButtonTheme: _getTextButtonData(),
    outlinedButtonTheme: _getOutlinedButtonData(),
    cardTheme: _getCardTheme(),
    appBarTheme: _getAppBarTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccentColor),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: appTextTheme,
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    shadowColor: Colors.grey.shade900,
    textButtonTheme: _getTextButtonData(),
    outlinedButtonTheme: _getOutlinedButtonData(),
    cardTheme: _getCardTheme(),
    appBarTheme: _getAppBarTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkAccentColor),
  );

  static Brightness? get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:themeMode == ThemeMode.light
            ? lightBackgroundColor
            : darkBackgroundColor,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light
            ? lightBackgroundColor
            : darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  static TextButtonThemeData _getTextButtonData() {
    return TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(1.sw, 50.h)),
        shape: MaterialStateProperty.resolveWith((states) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          } else {
            return Colors.white;
          }
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade300;
          } else {
            return lightPrimaryColor;
          }
        }),
      ),
    );
  }

  static OutlinedButtonThemeData _getOutlinedButtonData() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(
              color: Colors.grey,
            );
          } else {
            return BorderSide(color: lightPrimaryColor);
          }
        }),
        minimumSize: MaterialStateProperty.all(Size(1.sw, 50)),
        shape: MaterialStateProperty.resolveWith((states) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          } else {
            return lightPrimaryColor;
          }
        }),
      ),
    );
  }

  static CardTheme _getCardTheme() {
    return CardTheme(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static AppBarTheme _getAppBarTheme() {
    return AppBarTheme(
      backgroundColor: lightBackgroundColor,
      centerTitle: false,
      elevation: 0,
      iconTheme: IconThemeData(
        color: lightPrimaryColor,
      ),
    );
  }
}

extension ThemeExtras on ThemeData {
  Color get getDividerColor => brightness == Brightness.light
      ? AppTheme.lightDividerColor
      : AppTheme.darkDividerColor;
  Color get priceColor => AppTheme.priceColor;
}

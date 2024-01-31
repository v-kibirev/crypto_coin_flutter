import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    //primarySwatch: Colors.yellow,
    primarySwatch: Colors.yellow,
  ),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color.fromARGB(255, 35, 34, 34),
      // scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      )),
  scaffoldBackgroundColor: const Color.fromARGB(255, 35, 34, 34),
  dividerTheme: const DividerThemeData(
    color: Colors.white24,
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
      bodyMedium: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: Colors.white.withOpacity(0.6),
        fontWeight: FontWeight.w700,
      )),
  //brightness: Brightness.dark,
  useMaterial3: true,
);

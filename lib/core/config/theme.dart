import 'package:flutter/material.dart';

final theme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(0, 49),
      maximumSize: const Size.fromHeight(49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(0, 49),
      maximumSize: const Size.fromHeight(49),
    ),
  ),
);

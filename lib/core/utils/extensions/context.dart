import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextX on BuildContext {
  NavigatorState get navigation => Navigator.of(this);
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

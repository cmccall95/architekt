import 'package:flutter/material.dart';

extension GlobalKeyX on GlobalKey {
  RenderBox? get renderBox => currentContext?.findRenderObject() as RenderBox?;
}

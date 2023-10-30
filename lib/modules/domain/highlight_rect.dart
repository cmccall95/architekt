import 'dart:math';

import 'm_t_o_fields.dart';

class HighlightRect {
  HighlightRect({
    this.columnName,
    required double relativeX1,
    required double relativeX2,
    required double relativeY1,
    required double relativeY2,
  })  : relativeX1 = relativeX1.clamp(0, 1),
        relativeX2 = relativeX2.clamp(0, 1),
        relativeY1 = relativeY1.clamp(0, 1),
        relativeY2 = relativeY2.clamp(0, 1);

  final MTOField? columnName;
  final double relativeX1;
  final double relativeY1;
  final double relativeX2;
  final double relativeY2;

  double get originX => min(relativeX1, relativeX2);
  double get originY => min(relativeY1, relativeY2);
  double get width => (relativeX1 - relativeX2).abs();
  double get height => (relativeY1 - relativeY2).abs();

  HighlightRect transformSize({
    double? relativeX1,
    double? relativeX2,
    double? relativeY1,
    double? relativeY2,
  }) {
    return HighlightRect(
      columnName: columnName,
      relativeX1: relativeX1 ?? this.relativeX1,
      relativeX2: relativeX2 ?? this.relativeX2,
      relativeY1: relativeY1 ?? this.relativeY1,
      relativeY2: relativeY2 ?? this.relativeY2,
    );
  }

  HighlightRect transformPosition({
    double? offsetX,
    double? offsetY,
  }) {
    offsetX = offsetX?.clamp(0, 1 - width);
    offsetY = offsetY?.clamp(0, 1 - height);

    final relativeX1 = offsetX ?? originX;
    final relativeX2 = relativeX1 + width;
    final relativeY1 = offsetY ?? originY;
    final relativeY2 = relativeY1 + height;

    return HighlightRect(
      columnName: columnName,
      relativeX1: relativeX1,
      relativeX2: relativeX2,
      relativeY1: relativeY1,
      relativeY2: relativeY2,
    );
  }

  HighlightRect copyWith({
    MTOField? columnName,
    double? relativeX1,
    double? relativeX2,
    double? relativeY1,
    double? relativeY2,
  }) {
    return HighlightRect(
      columnName: columnName ?? this.columnName,
      relativeX1: relativeX1 ?? this.relativeX1,
      relativeX2: relativeX2 ?? this.relativeX2,
      relativeY1: relativeY1 ?? this.relativeY1,
      relativeY2: relativeY2 ?? this.relativeY2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'columnName': columnName?.value,
      'relativeX1': relativeX1,
      'relativeX2': relativeX2,
      'relativeY1': relativeY1,
      'relativeY2': relativeY2,
    };
  }
}

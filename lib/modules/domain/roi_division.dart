import 'package:equatable/equatable.dart';

import 'roi.dart';
import 'roi_columns.dart';

class RoiDivision extends Equatable {
  const RoiDivision({
    this.field,
    required this.relativeToRegionX0,
    required this.relativeToRegionY0,
    this.isEdge = false,
  });

  final RoiColumns? field;
  final double relativeToRegionX0;
  final double relativeToRegionY0;

  /// represent a region edge meaning the user can't interact with this division
  final bool isEdge;

  double toCanvasX0({
    required Roi region,
    required double canvasWidth,
  }) {
    final relativeX =
        (region.relativeWidth * relativeToRegionX0) + region.relativeOriginX;
    return relativeX;
  }

  double toCanvasY0({
    required Roi region,
    required double canvasHeight,
  }) {
    final relativeY =
        (region.relativeHeight * relativeToRegionY0) + region.relativeOriginY;
    return relativeY;
  }

  RoiDivision copyWith({
    RoiColumns? field,
    double? relativeToRegionX0,
    double? relativeToRegionY0,
  }) {
    return RoiDivision(
      field: field ?? this.field,
      relativeToRegionX0: relativeToRegionX0 ?? this.relativeToRegionX0,
      relativeToRegionY0: relativeToRegionY0 ?? this.relativeToRegionY0,
    );
  }

  @override
  List<Object?> get props => [
        field,
        relativeToRegionX0,
        relativeToRegionY0,
      ];

  @override
  bool get stringify => true;
}

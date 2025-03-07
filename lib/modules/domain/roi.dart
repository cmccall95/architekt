import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'roi_division.dart';
import 'roi_columns.dart';

class Roi extends Equatable {
  Roi({
    this.field,
    this.subregions = const [],
    required double relativeX0,
    required double relativeY0,
    required double relativeX1,
    required double relativeY1,
  })  : relativeX0 = relativeX0.clamp(0, 1),
        relativeY0 = relativeY0.clamp(0, 1),
        relativeX1 = relativeX1.clamp(0, 1),
        relativeY1 = relativeY1.clamp(0, 1);

  final RoiColumns? field;
  final List<RoiDivision> subregions;

  final double relativeX0;
  final double relativeY0;
  final double relativeX1;
  final double relativeY1;

  double get relativeOriginX => min(relativeX0, relativeX1);
  double get relativeOriginY => min(relativeY0, relativeY1);
  double get relativeWidth => (relativeX0 - relativeX1).abs();
  double get relativeHeight => (relativeY0 - relativeY1).abs();

  /// return the subregions without the last one which represent the edge of the
  /// region
  List<RoiDivision> get divisions {
    final subregions_ = subregions.toList();
    if (subregions_.isEmpty) return subregions_;

    subregions_.removeLast();
    return subregions_;
  }

  List<Roi> get subregionsAsRegions {
    List<Roi> subregions_ = [];
    for (var i = 0; i < subregions.length; i++) {
      double relativeX0_ = relativeOriginX;
      if (i > 0) {
        final previousDivision = subregions[i - 1];
        relativeX0_ = previousDivision.relativeToRegionX0 * relativeWidth;
        relativeX0_ += relativeOriginX;
      }

      final division = subregions[i];
      double relativeX1_ = division.relativeToRegionX0 * relativeWidth;
      relativeX1_ += relativeOriginX;

      final subregion = Roi(
        field: division.field,
        relativeX0: relativeX0_,
        relativeY0: relativeY0,
        relativeX1: relativeX1_,
        relativeY1: relativeY1,
      );

      subregions_.add(subregion);
    }

    return subregions_;
  }

  Roi copyWith({
    RoiColumns? field,
    double? relativeX0,
    double? relativeY0,
    double? relativeX1,
    double? relativeY1,
    List<RoiDivision>? subregions,
  }) {
    return Roi(
      field: field ?? this.field,
      relativeX0: relativeX0?.clamp(0, 1) ?? this.relativeX0,
      relativeY0: relativeY0?.clamp(0, 1) ?? this.relativeY0,
      relativeX1: relativeX1?.clamp(0, 1) ?? this.relativeX1,
      relativeY1: relativeY1?.clamp(0, 1) ?? this.relativeY1,
      subregions: subregions ?? this.subregions,
    );
  }

  static Roi fromJson(Map<String, dynamic> json) {
    final subregions = json[RegionFieldId.tableColumns.id] as List?;
    if (subregions == null) {
      return Roi(
        field: RoiColumns.fromString(json[RegionFieldId.columnName.id]),
        relativeX0: json[RegionFieldId.relativeX0.id] as double,
        relativeY0: json[RegionFieldId.relativeY0.id] as double,
        relativeX1: json[RegionFieldId.relativeX1.id] as double,
        relativeY1: json[RegionFieldId.relativeY1.id] as double,
      );
    }

    final coordinates = json[RegionFieldId.tableCoordinates.id];
    final parentRegion = Roi(
      field: RoiColumns.fromString(json[RegionFieldId.columnName.id]),
      relativeX0: coordinates[RegionFieldId.relativeX0.id] as double,
      relativeY0: coordinates[RegionFieldId.relativeY0.id] as double,
      relativeX1: coordinates[RegionFieldId.relativeX1.id] as double,
      relativeY1: coordinates[RegionFieldId.relativeY1.id] as double,
    );

    return parentRegion.copyWith(
      subregions: subregions.mapIndexed((index, e) {
        final region = Roi.fromJson(e);
        return region.toDivision(region: parentRegion);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final subregionsAsRegions_ = subregionsAsRegions.map((e) {
      return e.toJson();
    }).toList();

    if (subregionsAsRegions_.isEmpty) {
      return {
        RegionFieldId.columnName.id: field?.fieldId,
        RegionFieldId.relativeX0.id: relativeX0,
        RegionFieldId.relativeY0.id: relativeY0,
        RegionFieldId.relativeX1.id: relativeX1,
        RegionFieldId.relativeY1.id: relativeY1,
      };
    }

    return {
      RegionFieldId.columnName.id: field?.fieldId,
      RegionFieldId.tableCoordinates.id: {
        RegionFieldId.relativeX0.id: relativeX0,
        RegionFieldId.relativeY0.id: relativeY0,
        RegionFieldId.relativeX1.id: relativeX1,
        RegionFieldId.relativeY1.id: relativeY1,
      },
      RegionFieldId.tableColumns.id: subregionsAsRegions_,
    };
  }

  @override
  List<Object?> get props => [
        field,
        relativeX0,
        relativeX1,
        relativeY0,
        relativeY1,
        subregions,
      ];

  @override
  bool get stringify => true;
}

enum RegionFieldId {
  columnName('columnName'),
  relativeX0('relativeX0'),
  relativeY0('relativeY0'),
  relativeX1('relativeX1'),
  relativeY1('relativeY1'),
  tableCoordinates('tableCoordinates'),
  tableColumns('tableColumns');

  const RegionFieldId(this.id);
  final String id;
}

extension RegionMutable on Roi {
  Roi divideRegion(List<RoiColumns> tableFields) {
    if (tableFields.isEmpty) {
      return this;
    }

    final subregions_ = <RoiDivision>[];

    final rightEdge = tableFields.last;
    final fields = tableFields.sublist(0, tableFields.length - 1);
    final length = fields.length;

    final spacing = 1 / (length + 1);
    for (var i = 0; i < length; i++) {
      final relativeX0 = spacing * (i + 1);

      final division = RoiDivision(
        field: fields[i],
        relativeToRegionX0: relativeX0,
        relativeToRegionY0: 0.0,
      );

      subregions_.add(division);
    }

    final rightEdgeDivision = RoiDivision(
      field: rightEdge,
      relativeToRegionX0: 1.0,
      relativeToRegionY0: 0.0,
      isEdge: true,
    );

    subregions_.add(rightEdgeDivision);
    return copyWith(subregions: subregions_);
  }

  Roi divisionToRegion({
    required RoiDivision division,
    RoiDivision? previousDivision,
  }) {
    double relativeX0_ = 0;
    if (previousDivision != null) {
      relativeX0_ = previousDivision.relativeToRegionX0 * relativeWidth;
      relativeX0_ += relativeOriginX;
    }

    double relativeX1_ = division.relativeToRegionX0 * relativeWidth;
    relativeX1_ += relativeOriginX;

    return Roi(
      field: division.field,
      relativeX0: relativeX0_,
      relativeY0: relativeY0,
      relativeX1: relativeX1_,
      relativeY1: relativeY1,
    );
  }

  RoiDivision toDivision({
    required Roi region,
  }) {
    double relativeToRegionX0 = relativeX1 - region.relativeOriginX;
    relativeToRegionX0 /= region.relativeWidth;

    return RoiDivision(
      field: field,
      relativeToRegionX0: relativeToRegionX0,
      relativeToRegionY0: 0.0,
    );
  }

  Roi move({
    required Offset positionOnCanvas,
    required Offset startPositionOnCanvas,
    required double canvasWidth,
    required double canvasHeight,
    required double startOriginRelativeX,
    required double startOriginRelativeY,
    required double startRelativeWidth,
    required double startRelativeHeight,
  }) {
    final starXRelative = startPositionOnCanvas.dx / canvasWidth;
    final starYRelative = startPositionOnCanvas.dy / canvasHeight;
    final currXRelative = positionOnCanvas.dx / canvasWidth;
    final currYRelative = positionOnCanvas.dy / canvasHeight;

    final offsetX = currXRelative - (starXRelative - startOriginRelativeX);
    final offsetY = currYRelative - (starYRelative - startOriginRelativeY);

    final width = startRelativeWidth;
    final height = startRelativeHeight;

    final offsetXClamped = offsetX.clamp(0, 1 - width).toDouble();
    final offsetYClamped = offsetY.clamp(0, 1 - height).toDouble();

    return copyWith(
      relativeX0: offsetXClamped,
      relativeY0: offsetYClamped,
      relativeX1: offsetXClamped + width,
      relativeY1: offsetYClamped + height,
    );
  }

  Roi resize({
    required double startOriginRelativeX,
    required double startOriginRelativeY,
    required double startRelativeWidth,
    required double startRelativeHeight,
    double? leftRelative,
    double? topRelative,
    double? rightRelative,
    double? bottomRelative,
  }) {
    double? relativeX0;
    double? relativeY0;
    double? relativeX1;
    double? relativeY1;

    if (leftRelative != null) {
      relativeX0 = leftRelative;
      relativeX1 = startOriginRelativeX + startRelativeWidth;
    } else if (rightRelative != null) {
      relativeX0 = startOriginRelativeX;
      relativeX1 = rightRelative;
    }

    if (topRelative != null) {
      relativeY0 = topRelative;
      relativeY1 = startOriginRelativeY + startRelativeHeight;
    } else if (bottomRelative != null) {
      relativeY0 = startOriginRelativeY;
      relativeY1 = bottomRelative;
    }

    final region_ = copyWith(
      relativeX0: relativeX0,
      relativeY0: relativeY0,
      relativeX1: relativeX1,
      relativeY1: relativeY1,
    );

    if (region_.relativeWidth < 0.005) return this;
    if (region_.relativeHeight < 0.005) return this;

    return copyWith(
      relativeX0: region_.relativeX0,
      relativeY0: region_.relativeY0,
      relativeX1: region_.relativeX1,
      relativeY1: region_.relativeY1,
    );
  }

  Roi resizeDivision({
    required int index,
    required double regionWidth,
    required Offset positionOnRegion,
  }) {
    final divisions_ = subregions.toList();

    final division = divisions_.elementAtOrNull(index);
    if (division == null) return this;

    double minValue = 0;
    if (index > 0) {
      final previousDivision = divisions_[index - 1];
      minValue = previousDivision.relativeToRegionX0;
    }

    double maxValue = 1;
    if (index < divisions_.length - 1) {
      final nextDivision = divisions_[index + 1];
      maxValue = nextDivision.relativeToRegionX0;
    }

    final relativeX = positionOnRegion.dx / regionWidth;
    final relativeXClamped = relativeX.clamp(minValue, maxValue).toDouble();
    final newDivision = division.copyWith(relativeToRegionX0: relativeXClamped);

    divisions_[index] = newDivision;
    return copyWith(subregions: divisions_);
  }
}

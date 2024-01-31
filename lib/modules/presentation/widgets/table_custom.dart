import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/utils/types.dart';
import '../../domain/a_i_s_field.dart';
import '../../domain/a_i_s_table_data.dart';

part 'table_custom_body.dart';
part 'table_custom_cell.dart';
part 'table_custom_header.dart';

typedef TableBuilder = Widget Function(ScrollController horizontalController);

class TableCustom extends StatefulWidget {
  const TableCustom({
    Key? key,
    required this.bodyBuilder,
    required this.headerBuilder,
    this.minRowHeight = 32.0,
    this.minColumnWidth = 200.0,
    this.borderColor = const Color(0xFFe1e1e1),
    this.borderWidth = 0.5,
    this.selectedBorderColor = Colors.blue,
    this.selectedBorderWidth = 2.0,
    this.cellPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.cellAlignment = Alignment.centerLeft,
    this.evenRowColor = const Color(0xFFf5f5f5),
    this.oddRowColor = Colors.transparent,
    this.indexColumnWidth = 100.0,
  }) : super(key: key);

  final TableBuilder bodyBuilder;
  final TableBuilder headerBuilder;

  final double minRowHeight;
  final double minColumnWidth;
  final double indexColumnWidth;

  final Color borderColor;
  final double borderWidth;
  final Color selectedBorderColor;
  final double selectedBorderWidth;
  final EdgeInsets cellPadding;
  final Alignment cellAlignment;
  final Color evenRowColor;
  final Color oddRowColor;

  static TableSpecs of(BuildContext context) {
    final specs = context.dependOnInheritedWidgetOfExactType<TableSpecs>();
    assert(specs != null, 'No TableCustom found in context');
    return specs!;
  }

  @override
  State<TableCustom> createState() => _TableCustomState();
}

class _TableCustomState extends State<TableCustom> {
  final _headerScrollController = ScrollController();
  final _bodyScrollController = ScrollController();

  double get minColumnWidth => widget.minColumnWidth;
  double get minRowHeight => widget.minRowHeight;
  double get selectedBorderWidth => widget.selectedBorderWidth;
  double get borderWidth => widget.borderWidth;
  Color get borderColor => widget.borderColor;
  Color get selectedBorderColor => widget.selectedBorderColor;
  EdgeInsets get cellPadding => widget.cellPadding;
  Alignment get cellAlignment => widget.cellAlignment;
  Color get evenRowColor => widget.evenRowColor;
  Color get oddRowColor => widget.oddRowColor;
  double get indexColumnWidth => widget.indexColumnWidth;

  @override
  void initState() {
    super.initState();

    _headerScrollController.addListener(() {
      _bodyScrollController.jumpTo(_headerScrollController.offset);
    });

    _bodyScrollController.addListener(() {
      _headerScrollController.jumpTo(_bodyScrollController.offset);
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _bodyScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableSpecs(
      minRowHeight: minRowHeight,
      minColumnWidth: minColumnWidth,
      borderColor: borderColor,
      borderWidth: borderWidth,
      selectedBorderColor: selectedBorderColor,
      selectedBorderWidth: selectedBorderWidth,
      cellPadding: cellPadding,
      cellAlignment: cellAlignment,
      evenRowColor: evenRowColor,
      oddRowColor: oddRowColor,
      indexColumnWidth: indexColumnWidth,
      child: Column(
        children: [
          widget.headerBuilder(_headerScrollController),
          Expanded(child: widget.bodyBuilder(_bodyScrollController)),
        ],
      ),
    );
  }
}

class TableSpecs extends InheritedWidget {
  const TableSpecs({
    super.key,
    required super.child,
    required this.minRowHeight,
    required this.minColumnWidth,
    required this.borderColor,
    required this.borderWidth,
    required this.selectedBorderColor,
    required this.selectedBorderWidth,
    required this.cellPadding,
    required this.cellAlignment,
    required this.evenRowColor,
    required this.oddRowColor,
    required this.indexColumnWidth,
  });

  final double minRowHeight;
  final double minColumnWidth;
  final double indexColumnWidth;

  final Color borderColor;
  final double borderWidth;
  final Color selectedBorderColor;
  final double selectedBorderWidth;
  final Color evenRowColor;
  final Color oddRowColor;

  final EdgeInsets cellPadding;
  final Alignment cellAlignment;

  double get rowHeight => minRowHeight + selectedBorderWidth * 2;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return minRowHeight != (oldWidget as TableSpecs).minRowHeight ||
        minColumnWidth != oldWidget.minColumnWidth ||
        borderColor != oldWidget.borderColor ||
        borderWidth != oldWidget.borderWidth ||
        selectedBorderColor != oldWidget.selectedBorderColor ||
        selectedBorderWidth != oldWidget.selectedBorderWidth ||
        cellPadding != oldWidget.cellPadding ||
        cellAlignment != oldWidget.cellAlignment ||
        evenRowColor != oldWidget.evenRowColor ||
        oddRowColor != oldWidget.oddRowColor ||
        indexColumnWidth != oldWidget.indexColumnWidth;
  }
}

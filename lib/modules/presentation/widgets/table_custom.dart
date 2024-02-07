import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shimmer/shimmer.dart';

part 'table_custom_body.dart';
part 'table_custom_cell.dart';
part 'table_custom_header.dart';

typedef TableBuilder = Widget Function(ScrollController horizontalController);
typedef OrderBy<C> = ({C column, bool ascending});

class TableCustom<C, R> extends HookWidget {
  const TableCustom({
    Key? key,
    required this.columns,
    required this.rows,
    this.onColumnUpdated,
    required this.columnCellBuilder,
    required this.rowCellBuilder,
    required this.onLoadMore,
    required this.hasMore,
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

  final List<C> columns;
  final AsyncValue<List<R>> rows;

  final void Function() onLoadMore;
  final bool hasMore;

  final void Function(C column, bool ascending)? onColumnUpdated;
  final String Function(C column) columnCellBuilder;
  final Widget Function(R row, C column) rowCellBuilder;

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
  Widget build(BuildContext context) {
    final headerScrollController = useScrollController();
    final bodyScrollController = useScrollController();

    useEffect(() {
      void headerListener() {
        bodyScrollController.jumpTo(headerScrollController.offset);
      }

      void bodyListener() {
        headerScrollController.jumpTo(bodyScrollController.offset);
      }

      bodyScrollController.addListener(bodyListener);
      headerScrollController.addListener(headerListener);

      return () {
        bodyScrollController.removeListener(bodyListener);
        headerScrollController.removeListener(headerListener);
      };
    }, [headerScrollController, bodyScrollController]);

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
          TableCustomHeader<C>(
            horizontalScrollController: headerScrollController,
            columns: columns,
            cellBuilder: columnCellBuilder,
          ),
          Expanded(
            child: TableCustomBody<C, R>(
              horizontalScrollController: bodyScrollController,
              columns: columns,
              cellBuilder: rowCellBuilder,
              rows: rows,
              hasMore: hasMore,
              onLoadMore: onLoadMore,
            ),
          ),
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

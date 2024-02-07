part of 'table_custom.dart';

class TableCustomBody<C, R> extends StatefulWidget {
  const TableCustomBody({
    super.key,
    required this.horizontalScrollController,
    required this.rows,
    required this.columns,
    required this.cellBuilder,
    required this.onLoadMore,
    required this.hasMore,
  });

  final List<C> columns;
  final AsyncValue<List<R>> rows;
  final bool hasMore;
  final ScrollController horizontalScrollController;

  final VoidCallback onLoadMore;
  final Widget Function(R row, C column) cellBuilder;

  @override
  State<TableCustomBody<C, R>> createState() => _TableCustomBodyState<C, R>();
}

class _TableCustomBodyState<C, R> extends State<TableCustomBody<C, R>> {
  final _rowsScrollController = ScrollController();

  Timer? _timer;

  List<C> get columns => widget.columns;
  AsyncValue<List<R>> get rows => widget.rows;

  double calculateColumnWidth({
    required BoxConstraints constraints,
    required double minColumnWidth,
  }) {
    var columnWidth = minColumnWidth;
    final maxWidth = constraints.maxWidth;
    final columnsCount = widget.columns.length;

    if (columnWidth * columnsCount < maxWidth) {
      columnWidth = maxWidth / columnsCount;
    }

    return columnWidth;
  }

  @override
  void initState() {
    super.initState();

    _rowsScrollController.addListener(() {
      if (_rowsScrollController.position.extentAfter > 0) {
        return;
      }

      if (_timer != null && _timer!.isActive) {
        return;
      }

      _timer = Timer(const Duration(seconds: 1), () {});
      widget.onLoadMore.call();
    });
  }

  @override
  void dispose() {
    _rowsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);
    final indexPlus = widget.hasMore ? 0 : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = calculateColumnWidth(
          constraints: constraints,
          minColumnWidth: specs.minColumnWidth,
        );

        final rowWidth = columnWidth * columns.length;
        final indexWidth = specs.indexColumnWidth;

        switch (rows) {
          case AsyncError(:final error):
            return Center(
              child: Text(error.toString()),
            );

          case AsyncData(:final value):
            if (value.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }

            return SingleChildScrollView(
              controller: widget.horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: rowWidth + indexWidth,
                child: ListView.builder(
                  controller: _rowsScrollController,
                  itemCount: value.length + indexPlus,
                  itemBuilder: (context, index) {
                    if (index == value.length) {
                      return _RowLoadingShimmer(
                        rowsCount: 2,
                        columnWidth: columnWidth,
                        columnsCount: columns.length,
                      );
                    }

                    final item = value[index];
                    return Container(
                      height: specs.rowHeight,
                      color:
                          index.isEven ? specs.evenRowColor : specs.oddRowColor,
                      child: Row(
                        children: [
                          SizedBox(
                            width: specs.indexColumnWidth,
                            child: TableCustomCell.text(
                              value: (index + 1).toString(),
                            ),
                          ),
                          ...columns.map((column) {
                            return widget.cellBuilder(item, column);
                          }).toList()
                        ],
                      ),
                    );
                  },
                ),
              ),
            );

          default:
            return SingleChildScrollView(
              controller: widget.horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: _RowLoadingShimmer(
                  rowsCount: 30,
                  columnWidth: columnWidth,
                  columnsCount: columns.length,
                ),
              ),
            );
        }
      },
    );
  }
}

class _RowLoadingShimmer extends StatelessWidget {
  const _RowLoadingShimmer({
    required this.columnWidth,
    required this.columnsCount,
    required this.rowsCount,
  });

  final double columnWidth;
  final int columnsCount;
  final int rowsCount;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    return Column(
      children: List.generate(rowsCount, (rowIndex) {
        final color = rowIndex.isEven ? specs.evenRowColor : specs.oddRowColor;
        return Container(
          color: color,
          child: Row(
            children: List.generate(columnsCount + 1, (index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  height: specs.rowHeight,
                  width: specs.indexColumnWidth,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: specs.rowHeight * 0.8,
                      width: columnWidth * 0.95,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Container(
                alignment: Alignment.center,
                height: specs.rowHeight,
                width: columnWidth,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                    height: specs.rowHeight * 0.8,
                    width: columnWidth * 0.95,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

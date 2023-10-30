part of 'table_custom.dart';

class TableCustomBody extends StatefulWidget {
  const TableCustomBody({
    super.key,
    required this.horizontalScrollController,
    required this.rows,
    required this.columns,
    required this.cellBuilder,
    required this.onLoadMore,
    required this.isLastPage,
  });

  final List<MTOField> columns;
  final List<MTO> rows;
  final bool isLastPage;
  final ScrollController horizontalScrollController;

  final VoidCallback onLoadMore;
  final Widget Function(MTO mto, MTOField column) cellBuilder;

  @override
  State<TableCustomBody> createState() => _TableCustomBodyState();
}

class _TableCustomBodyState extends State<TableCustomBody> {
  final _rowsScrollController = ScrollController();

  List<MTOField> get columns => widget.columns;
  List<MTO> get rows => widget.rows;

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
      if (_rowsScrollController.position.extentAfter != 0) {
        return;
      }

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
    final indexPlus = widget.isLastPage ? 1 : 0;

    return LayoutBuilder(builder: (context, constraints) {
      final columnWidth = calculateColumnWidth(
        constraints: constraints,
        minColumnWidth: TableCustom.of(context).minColumnWidth,
      );

      return SingleChildScrollView(
        controller: widget.horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: columnWidth * widget.columns.length,
          child: ListView.builder(
            controller: _rowsScrollController,
            itemCount: rows.length + indexPlus,
            itemBuilder: (context, index) {
              if (index == widget.rows.length) {
                return Container(
                  height: specs.rowHeight * 2,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              final item = widget.rows[index];
              return SizedBox(
                height: specs.rowHeight,
                child: Row(
                  children: columns.map((column) {
                    return widget.cellBuilder(item, column);
                  }).toList(),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

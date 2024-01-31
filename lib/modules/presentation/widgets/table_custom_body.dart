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

  final List<AISField> columns;
  final List<AISTableData> rows;
  final bool isLastPage;
  final ScrollController horizontalScrollController;

  final VoidCallback onLoadMore;
  final Widget Function(AISTableData data, AISField column) cellBuilder;

  @override
  State<TableCustomBody> createState() => _TableCustomBodyState();
}

class _TableCustomBodyState extends State<TableCustomBody> {
  final _rowsScrollController = ScrollController();

  Timer? _timer;

  List<AISField> get columns => widget.columns;
  List<AISTableData> get rows => widget.rows;

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
    final indexPlus = widget.isLastPage ? 0 : 1;

    return LayoutBuilder(builder: (context, constraints) {
      final columnWidth = calculateColumnWidth(
        constraints: constraints,
        minColumnWidth: specs.minColumnWidth,
      );

      return SingleChildScrollView(
        controller: widget.horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: columnWidth * widget.columns.length + specs.indexColumnWidth,
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

              return Container(
                height: specs.rowHeight,
                color: index.isEven ? specs.evenRowColor : specs.oddRowColor,
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
    });
  }
}

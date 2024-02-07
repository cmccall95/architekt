part of 'table_custom.dart';

class TableCustomHeader<C> extends StatelessWidget {
  const TableCustomHeader({
    super.key,
    required this.horizontalScrollController,
    required this.columns,
    this.orderBy,
    this.onOrderByChanged,
    this.cellBuilder,
  });

  final ScrollController horizontalScrollController;
  final List<C> columns;
  final OrderBy<C>? orderBy;
  final void Function(OrderBy<C> orderBy)? onOrderByChanged;
  final String Function(C column)? cellBuilder;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    return SizedBox(
      height: specs.rowHeight,
      child: ListView.builder(
        controller: horizontalScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: columns.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(
              width: specs.indexColumnWidth,
            );
          }

          final column = columns[index - 1];
          Widget? sortingIndicator;
          if (orderBy != null && orderBy!.column == column) {
            sortingIndicator = Icon(
              orderBy!.ascending
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            );
          }

          return TableCustomCell(
            onTap: () {
              var ascending = true;
              if (orderBy != null && orderBy!.column == column) {
                ascending = !orderBy!.ascending;
              }

              onOrderByChanged?.call((
                column: column,
                ascending: ascending,
              ));
            },
            child: Row(
              children: [
                if (sortingIndicator != null) ...[
                  sortingIndicator,
                  const SizedBox(width: 4),
                ],
                Text(
                  cellBuilder?.call(column) ?? '$column',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

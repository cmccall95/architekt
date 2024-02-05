part of 'table_custom.dart';

class TableCustomHeader extends StatelessWidget {
  const TableCustomHeader({
    super.key,
    required this.horizontalScrollController,
    required this.columns,
    this.sort,
    this.onSort,
  });

  final ScrollController horizontalScrollController;
  final List<MtoColumns> columns;
  final OrderBy? sort;
  final ValueChanged<OrderBy>? onSort;

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

          final column = columns[index];

          Widget? sortingIndicator;
          if (sort != null && sort!.column == column) {
            sortingIndicator = Icon(
              sort!.ascending
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            );
          }

          return TableCustomCell(
            onTap: () {
              var ascending = true;
              if (sort != null && sort!.column == column) {
                ascending = !sort!.ascending;
              }

              onSort?.call((
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
                  column.displayName,
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

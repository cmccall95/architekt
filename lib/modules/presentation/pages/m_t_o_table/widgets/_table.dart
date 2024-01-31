part of '../m_t_o_table_page.dart';

class _Table extends ConsumerWidget {
  const _Table({
    required this.tableName,
  });

  final String tableName;

  void _onLoadMore(WidgetRef ref) {
    final provider = getTableRowsPaginationProvider(tableName);
    final paginationAvailable = ref.read(provider);

    switch (paginationAvailable) {
      case AsyncError():
        ref.invalidate(provider);
      case AsyncData(:final value):
        if (!value) return;

        final notifier = ref.read(provider.notifier);
        notifier.fetchNextBatch();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(getTableRowsControllerProvider(tableName));
    const columns = AISField.values;

    final pagination = ref.watch(getTableRowsPaginationProvider(tableName));
    final isLastPage = pagination.maybeWhen(
      data: (value) => !value,
      orElse: () => false,
    );

    return TableCustom(
      headerBuilder: (horizontalScrollController) {
        return TableCustomHeader(
          horizontalScrollController: horizontalScrollController,
          columns: columns,
          sort: null,
          onSort: (orderBy) {},
        );
      },
      bodyBuilder: (horizontalScrollController) {
        return rows.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }

            return TableCustomBody(
              horizontalScrollController: horizontalScrollController,
              rows: data,
              columns: columns,
              onLoadMore: () => _onLoadMore(ref),
              isLastPage: isLastPage,
              cellBuilder: (data, column) {
                return _MTOTableCell(
                  row: data.data,
                  column: column,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _MTOTableCell extends StatelessWidget {
  const _MTOTableCell({
    required this.row,
    required this.column,
  });

  final AISData row;
  final AISField column;

  @override
  Widget build(BuildContext context) {
    final value = row.dataFromField(column);
    // final selectedRow = Get.find<EditTableRowController>().row.value;
    // final selectedColumn = Get.find<EditTableRowController>().column.value;

    // final isSameRow = selectedRow?.databaseId == row.databaseId;
    // final isSameColumn = selectedColumn?.value == column.value;

    // final isSelected = isSameRow && isSameColumn;

    return TableCustomCell.textField(
      value: value,
      isSelected: false,
      onTap: () {
        // AISData? row_ = row;
        // AISField? column_ = column;

        // if (isSelected) {
        //   row_ = null;
        //   column_ = null;
        // }

        // Get.find<EditTableRowController>().row.value = row_;
        // Get.find<EditTableRowController>().column.value = column_;
      },
      onChanged: (value) {
        // _updateField(
        //   mto: row,
        //   column: column,
        //   value: value.toString(),
        // );
      },
    );
  }
}

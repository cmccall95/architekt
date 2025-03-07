part of '../m_t_o_table_page.dart';

class _MtoTable extends ConsumerWidget {
  const _MtoTable();

  void _onLoadMore(WidgetRef ref) {
    final paginationAvailable = ref.read(getMtosPaginationProvider);
    switch (paginationAvailable) {
      case AsyncError():
        ref.invalidate(getMtosPaginationProvider);
      case AsyncData(:final value):
        if (!value) return;

        final notifier = ref.read(getMtosPaginationProvider.notifier);
        notifier.fetchNextBatch();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _MtoTableColumnsLoader(
      builder: (columns) {
        final rows = ref.watch(getMtosControllerProvider);

        final pagination = ref.watch(getMtosPaginationProvider);
        final isLastPage = pagination.maybeWhen(
          data: (value) => !value,
          orElse: () => false,
        );

        return TableCustom(
          columns: columns,
          columnCellBuilder: (column) => column.displayName,
          rows: rows,
          onLoadMore: () => _onLoadMore(ref),
          hasMore: isLastPage,
          rowCellBuilder: (row, column) {
            return TableCustomCell.textField(
              value: row.data.dataFromField(column),
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
          },
        );
      },
    );
  }
}

class _MtoTableColumnsLoader extends ConsumerWidget {
  const _MtoTableColumnsLoader({
    super.key,
    required this.builder,
  });

  final Widget Function(List<MtoColumns> columns) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final columns = ref.watch(mtoColumnsControllerProvider);
    return columns.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      data: builder,
    );
  }
}

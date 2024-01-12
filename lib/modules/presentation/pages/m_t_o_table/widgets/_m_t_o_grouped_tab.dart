part of '../m_t_o_table_page.dart';

class _MTOGroupedTab extends StatelessWidget {
  const _MTOGroupedTab({super.key});

  void _onLoadMore() {
    final controller = Get.find<GetMTOsGroupedController>();
    if (controller.isLastPage.value) {
      return;
    }

    if (controller.paginationState.isLoading) {
      return;
    }

    controller.fetchNextBatch();
  }

  @override
  Widget build(BuildContext context) {
    const columns = MTOField.values;
    return TableCustom(
      headerBuilder: (horizontalScrollController) {
        return Obx(() {
          final controller = Get.find<GetMTOsGroupedController>();

          return TableCustomHeader(
            horizontalScrollController: horizontalScrollController,
            columns: columns,
            sort: controller.orderBy.value,
            onSort: (orderBy) {
              controller.orderBy.value = orderBy;
              controller.fetchFirstBatch();
            },
          );
        });
      },
      bodyBuilder: (horizontalScrollController) {
        return _MTOGroupProcessing(
          builder: (context) {
            return Obx(() {
              final state = Get.find<GetMTOsGroupedController>().stateValue;
              if (state.value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.value.hasError) {
                return Center(
                  child: Text(state.value.asError.message),
                );
              }

              final data = state.value.asData.data ?? [];
              if (data.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }

              return TableCustomBody(
                horizontalScrollController: horizontalScrollController,
                rows: data,
                columns: columns,
                onLoadMore: _onLoadMore,
                isLastPage:
                    Get.find<GetMTOsGroupedController>().isLastPage.value,
                cellBuilder: (mto, column) {
                  return _MTOGroupedTableCell(
                    row: mto,
                    column: column,
                  );
                },
              );
            });
          },
        );
      },
    );
  }
}

class _MTOGroupedTableCell extends StatelessWidget {
  const _MTOGroupedTableCell({
    required this.row,
    required this.column,
  });

  final MTO row;
  final MTOField column;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final value = row.getValueFromField(column);
      final selectedRow = Get.find<EditTableRowController>().row.value;
      final selectedColumn = Get.find<EditTableRowController>().column.value;

      final isSameRow = selectedRow?.pipeSpec == row.pipeSpec;
      final isSameColumn = selectedColumn?.value == column.value;

      final isSelected = isSameRow && isSameColumn;

      return TableCustomCell(
        isSelected: isSelected,
        onTap: () {
          MTO? row_ = row;
          MTOField? column_ = column;

          if (isSelected) {
            row_ = null;
            column_ = null;
          }

          Get.find<EditTableRowController>().row.value = row_;
          Get.find<EditTableRowController>().column.value = column_;
        },
        child: Text(value ?? ''),
      );
    });
  }
}

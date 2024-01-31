part of '../m_t_o_table_page.dart';

class _TableLoader extends ConsumerWidget {
  const _TableLoader({
    Key? key,
    required this.table,
  }) : super(key: key);

  final AISTable table;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableController = ref.watch(loadTableControllerProvider(table));
    return tableController.when(
      loading: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('Building database...'),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      data: (_) {
        return _Table(tableName: table.name);
      },
    );
  }
}

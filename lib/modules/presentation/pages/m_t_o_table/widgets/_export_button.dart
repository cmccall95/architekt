part of '../m_t_o_table_page.dart';

class _ExportButton extends ConsumerWidget {
  const _ExportButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () async {
          final notifier = ref.read(exportExcelControllerProvider.notifier);
          notifier.exportToXlsx();
        },
        icon: const Icon(Icons.download),
        label: const Text('Export'),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.theme.appBarTheme.iconTheme?.color,
        ),
      ),
    );
  }
}

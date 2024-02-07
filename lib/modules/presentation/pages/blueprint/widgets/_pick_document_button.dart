part of '../blueprint_page.dart';

class PickDocumentButton extends ConsumerWidget {
  const PickDocumentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () async {
          final notifier = ref.read(blueprintPdfControllerProvider.notifier);
          await notifier.pickDocument();
        },
        label: const Text('Pick File'),
        icon: const Icon(Icons.upload_rounded),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.theme.appBarTheme.iconTheme?.color,
        ),
      ),
    );
  }
}

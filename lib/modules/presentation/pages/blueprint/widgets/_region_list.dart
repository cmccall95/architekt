part of '../blueprint_page.dart';

class _RegionsList extends ConsumerWidget {
  const _RegionsList({super.key});

  Future<void> uploadCoordinates({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final coordinates = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );

    if (coordinates == null) {
      return;
    }

    final file = File(coordinates.files.single.path!);
    final contents = await file.readAsString();
    if (!context.mounted) return;

    final json = jsonDecode(contents);
    if (json is! List) {
      ErrorDialog.show(
        context: context,
        title: 'Invalid file',
        message: 'The file must contain a list of regions',
      );

      return;
    }

    final regions = json.map((e) => Roi.fromJson(e)).toList();

    final notifier = ref.read(regionListControllerProvider.notifier);
    notifier.clear();
    notifier.addRegions(regions);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 56,
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 56 + 8),
                Expanded(
                  child: Text(
                    'Columns to extract',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 56,
                  child: TextButton(
                    onPressed: () => uploadCoordinates(
                      context: context,
                      ref: ref,
                    ),
                    child: const Icon(Icons.upload_rounded),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final regions = ref.watch(regionListControllerProvider);
                if (regions.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: const Text(
                      'Add a column by dragging the area on the PDF',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: regions.length,
                  itemBuilder: (context, index) {
                    return ColumnItem(
                      index: index,
                      region: regions[index],
                    );
                  },
                );
              },
            ),
          ),
          const _ClearButton(),
        ],
      ),
    );
  }
}

class _ClearButton extends ConsumerWidget {
  const _ClearButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regions = ref.watch(regionListControllerProvider);
    final notifier = ref.watch(regionListControllerProvider.notifier);

    if (regions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 56,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => notifier.clear(),
        child: const Text('Clear all'),
      ),
    );
  }
}

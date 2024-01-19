part of '../blueprint_page.dart';

class _RegionsList extends StatelessWidget {
  const _RegionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              'Columns to extract',
              style: Theme.of(context).textTheme.titleSmall,
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

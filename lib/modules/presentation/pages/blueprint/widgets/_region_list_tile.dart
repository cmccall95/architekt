part of '../blueprint_page.dart';

class ColumnItem extends ConsumerWidget {
  const ColumnItem({
    super.key,
    required this.index,
    required this.region,
  });

  final int index;
  final Region region;

  void _onDelete({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final indexNotifier = ref.read(regionIndexControllerProvider.notifier);
    indexNotifier.unselect();

    final notifier = ref.read(regionListControllerProvider.notifier);
    notifier.removeRegion(region);
  }

  void _onEdit({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final region_ = await _EditRegionDialog.show(
      context: context,
      region: region,
    );

    if (region_ != null) {
      final notifier = ref.read(regionListControllerProvider.notifier);
      notifier.updateRegion(region, region_);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(regionIndexControllerProvider);
    final isSelected = selectedIndex == index;

    Color color = Colors.transparent;
    if (isSelected) {
      color = Colors.blue.withOpacity(0.2);
    }

    return Card(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          final notifier = ref.read(regionIndexControllerProvider.notifier);
          notifier.select(index);
        },
        child: Container(
          height: 56,
          color: color,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(region.field?.name ?? '-'),
              ),
              PopupMenuButton(
                onSelected: (value) async {
                  switch (value) {
                    case _PopupAction.edit:
                      _onEdit(context: context, ref: ref);
                    case _PopupAction.delete:
                      _onDelete(context: context, ref: ref);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: _PopupAction.edit,
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: _PopupAction.delete,
                    child: Text('Delete'),
                  ),
                ],
                child: IgnorePointer(
                  child: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.more_vert),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _PopupAction {
  edit,
  delete,
}

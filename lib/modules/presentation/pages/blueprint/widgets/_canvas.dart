part of '../blueprint_page.dart';

class _Canvas extends HookConsumerWidget {
  const _Canvas({
    required this.canvasWidth,
    required this.canvasHeight,
  });

  final double canvasWidth;
  final double canvasHeight;

  Future<void> _onCreateRegion({
    required WidgetRef ref,
    required Region rawRegion,
  }) async {
    final region_ = await _EditRegionDialog.show(
      context: ref.context,
      region: rawRegion,
    );

    if (region_ != null) {
      final notifier = ref.read(regionListControllerProvider.notifier);
      notifier.addRegion(region_);

      final regions = ref.read(regionListControllerProvider);
      final regionIndex = regions.indexOf(region_);

      final indexNotifier = ref.read(regionIndexControllerProvider.notifier);
      indexNotifier.select(regionIndex);
    }
  }

  void _onUpdateRegionShape({
    required WidgetRef ref,
    required Region oldRegion,
    required Region rawRegion,
  }) {
    final notifier = ref.read(regionListControllerProvider.notifier);
    notifier.updateRegion(oldRegion, rawRegion);
  }

  void _onSelectRegion({
    required WidgetRef ref,
    required int index,
  }) {
    final indexNotifier = ref.read(regionIndexControllerProvider.notifier);
    indexNotifier.select(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasKey = useMemoized(() => GlobalKey());

    final regions = ref.watch(regionListControllerProvider);
    final region = ref.watch(createRegionControllerProvider);

    Widget? painter;
    if (region != null) {
      final width = canvasWidth * region.relativeWidth;
      final height = canvasHeight * region.relativeHeight;

      painter = Positioned(
        left: canvasWidth * region.relativeOriginX,
        top: canvasHeight * region.relativeOriginY,
        width: width,
        height: height,
        child: CustomPaint(
          size: Size(width, height),
          painter: _RegionPainter(
            isSelected: true,
            canvasWidth: canvasWidth,
            canvasHeight: canvasHeight,
            region: region,
          ),
        ),
      );
    }

    return Container(
      width: canvasWidth,
      height: canvasHeight,
      color: Colors.transparent,
      key: canvasKey,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: _RegionCreator(
              canvasWidth: canvasWidth,
              canvasHeight: canvasHeight,
              canvasKey: canvasKey,
              onRegionChanged: (region) => _onCreateRegion(
                ref: ref,
                rawRegion: region,
              ),
            ),
          ),
          ...regions.mapIndexed((index, rect) {
            final selectedIndex = ref.watch(regionIndexControllerProvider);
            return _RegionPreview(
              region: rect,
              canvasWidth: canvasWidth,
              canvasHeight: canvasHeight,
              canvasKey: canvasKey,
              isSelected: selectedIndex == index,
              onRegionChanged: (value) => _onUpdateRegionShape(
                ref: ref,
                oldRegion: rect,
                rawRegion: value,
              ),
              onRegionSelected: (value) => _onSelectRegion(
                ref: ref,
                index: index,
              ),
            );
          }).toList(),
          if (painter != null) painter,
        ],
      ),
    );
  }
}

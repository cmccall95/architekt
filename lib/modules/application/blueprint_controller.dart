import 'package:get/get.dart';

import '../domain/highlight_rect.dart';

class BlueprintController {
  final highlightRects = RxList<HighlightRect>.empty();
  final selectedIndex = Rx<int?>(null);

  final isTopLeftSelected = false.obs;
  final isTopRightSelected = false.obs;
  final isBottomLeftSelected = false.obs;
  final isBottomRightSelected = false.obs;

  void onSelectRect(HighlightRect? rect) {
    final index = highlightRects.indexOf(rect);
    if (index == -1) return;

    selectedIndex.value = index;
  }

  void onUnselectRect() {
    selectedIndex.value = null;
  }

  void addRect(HighlightRect rect) {
    highlightRects.add(rect);
  }

  void removeRect(HighlightRect rect) {
    final index = highlightRects.indexOf(rect);
    if (index == -1) return;

    highlightRects.removeAt(index);

    if (selectedIndex.value == null) {
      return;
    }

    if (selectedIndex.value == index) {
      selectedIndex.value = null;
      return;
    }

    if (selectedIndex.value! > index) {
      selectedIndex.value = selectedIndex.value! - 1;
      return;
    }
  }

  void clearRects() {
    highlightRects.clear();
    selectedIndex.value = null;
  }
}

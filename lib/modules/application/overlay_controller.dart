import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OverlayController {
  final _entry = Rxn<OverlayEntry>(null);

  void showOverlay({
    required BuildContext context,
    required OverlayEntry entry,
  }) {
    _entry.value?.remove();
    _entry.value = entry;

    Overlay.of(context).insert(entry);
  }

  void hideOverlay() {
    _entry.value?.remove();
    _entry.value = null;
  }
}

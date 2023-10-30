import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../application/blueprint_controller.dart';
import '../../../../domain/m_t_o_fields.dart';
import '../../../../domain/highlight_rect.dart';

class ColumnItem extends StatefulWidget {
  const ColumnItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<ColumnItem> createState() => _ColumnItemState();
}

class _ColumnItemState extends State<ColumnItem> {
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  void _onChangeColumnName(MTOField column) {
    final controller = Get.find<BlueprintController>();
    final rect = controller.highlightRects[widget.index];
    controller.highlightRects[widget.index] = rect.copyWith(columnName: column);

    _focusNode.unfocus();
  }

  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final rect = Get.find<BlueprintController>().highlightRects[widget.index];

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: _ColumnNamesDropdown(
              rect: rect,
              onSelected: _onChangeColumnName,
            ),
          ),
        );
      },
    );
  }

  void _onDelete(HighlightRect rect) {
    Get.find<BlueprintController>().removeRect(rect);
  }

  void _onTap() {
    Get.find<BlueprintController>().selectedIndex.value = widget.index;
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      final overlayState = Overlay.of(context);
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();
        overlayState.insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintController>();
      final rect = controller.highlightRects[widget.index];
      final isSelected = controller.selectedIndex.value == widget.index;

      Color color = Colors.transparent;
      if (isSelected) {
        color = Colors.blue.withOpacity(0.2);
      }

      return CompositedTransformTarget(
        link: _layerLink,
        child: Card(
          margin: const EdgeInsets.all(5),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            focusNode: _focusNode,
            onTap: _onTap,
            child: Container(
              height: 56,
              color: color,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(rect.columnName?.name ?? '-'),
                  ),
                  TextButton(
                    onPressed: () => _onDelete(rect),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _ColumnNamesDropdown extends StatelessWidget {
  const _ColumnNamesDropdown({
    required this.rect,
    required this.onSelected,
  });

  final HighlightRect rect;
  final ValueChanged<MTOField> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxHeight: 56 * 5,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: MTOField.values.length,
          itemBuilder: (context, index) {
            final columnName = MTOField.values[index];
            final isCurrent = columnName == rect.columnName;

            return ListTile(
              selected: isCurrent,
              selectedTileColor: Colors.blue.withOpacity(0.2),
              title: Text(columnName.name),
              onTap: () => onSelected(columnName),
            );
          },
        ),
      ),
    );
  }
}

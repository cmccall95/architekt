import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/roi_columns.dart';

part 'field_selector.g.dart';

class FieldSelector extends HookConsumerWidget {
  const FieldSelector({
    super.key,
    this.field,
    required this.onFieldChanged,
    this.suffixIcon,
    this.validator,
  });

  final RoiColumns? field;
  final ValueChanged<RoiColumns> onFieldChanged;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  OverlayEntry _createOverlay({
    required BuildContext context,
    required LayerLink layerLink,
  }) {
    final renderBox = context.findRenderObject() as RenderBox;

    final size = renderBox.size;
    final dy = renderBox.localToGlobal(Offset.zero).dy + size.height + 5;
    final maxHeight = MediaQuery.of(context).size.height - dy;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: _OptionsDropdown(
              maxHeight: maxHeight,
              onValueChanged: onFieldChanged,
            ),
          ),
        );
      },
    );
  }

  void _onFocusUpdate({
    required FocusNode focusNode,
    required BuildContext context,
    required LayerLink layerLink,
    required OverlayEntry? entry,
    required ValueChanged<OverlayEntry?> onEntryChanged,
    required VoidCallback onGainFocus,
    required VoidCallback onLoseFocus,
  }) {
    if (focusNode.hasFocus) {
      final entry_ = _createOverlay(
        context: context,
        layerLink: layerLink,
      );

      Overlay.of(context).insert(entry_);
      onEntryChanged(entry_);
      onGainFocus();
    } else {
      entry?.remove();
      onEntryChanged(null);
      onLoseFocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timestamp = useState(DateTime.now().millisecondsSinceEpoch);
    final focusNode = useFocusNode();
    final layerLink = useMemoized(() => LayerLink());
    final entry = useState<OverlayEntry?>(null);

    useEffect(() {
      void listener() => _onFocusUpdate(
            focusNode: focusNode,
            context: context,
            layerLink: layerLink,
            entry: entry.value,
            onEntryChanged: (value) => entry.value = value,
            onGainFocus: () {},
            onLoseFocus: () {
              timestamp.value = DateTime.now().millisecondsSinceEpoch;
            },
          );

      focusNode.addListener(listener);
      return () => focusNode.removeListener(listener);
    }, [focusNode, onFieldChanged]);

    return CompositedTransformTarget(
      link: layerLink,
      child: TextFormField(
        key: ValueKey('textfield_${field}_${timestamp.value}'),
        focusNode: focusNode,
        initialValue: field?.defaultName,
        validator: validator,
        onChanged: (value) {
          final notifier = ref.read(_fieldNameProvider.notifier);
          notifier.state = value;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Column name',
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class _OptionsDropdown extends ConsumerWidget {
  const _OptionsDropdown({
    required this.maxHeight,
    required this.onValueChanged,
  });

  final ValueChanged<RoiColumns> onValueChanged;
  final double maxHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(_fieldNameProvider);

    final columns = RoiColumns.values.where((element) {
      final name = element.name.toLowerCase();
      return name.contains(query?.toLowerCase() ?? '');
    }).toList();

    final maxHeight_ = maxHeight - 48;
    final minHeight_ = 48 * min(8, columns.length);
    final height = min(minHeight_, maxHeight_).toDouble();

    return TextFieldTapRegion(
      child: Material(
        elevation: 5,
        child: SizedBox(
          height: height,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: columns.length,
            itemBuilder: (context, index) {
              final field = columns[index];

              return ListTile(
                title: Text(field.defaultName),
                onTap: () {
                  final notifier = ref.read(_fieldNameProvider.notifier);
                  notifier.state = '';

                  onValueChanged(field);
                  FocusScope.of(context).unfocus();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

@riverpod
class _FieldName extends _$FieldName {
  @override
  set state(String? value) => super.state = value;

  @override
  String? build() {
    return null;
  }
}

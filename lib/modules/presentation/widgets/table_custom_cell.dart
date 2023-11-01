part of 'table_custom.dart';

typedef SelectedCell = ({
  MTO row,
  MTOField column,
});

enum TableCustomCellType {
  custom,
  dropdown,
  textField;

  bool get isDropdown => this == TableCustomCellType.dropdown;
  bool get isTextField => this == TableCustomCellType.textField;
  bool get isCustom => this == TableCustomCellType.custom;
}

class TableCustomCell extends StatelessWidget {
  const TableCustomCell({
    super.key,
    this.child,
    this.onTap,
    this.isSelected = false,
  })  : value = null,
        options = null,
        onChanged = null,
        type = TableCustomCellType.custom;

  const TableCustomCell.dropdown({
    super.key,
    this.value,
    required this.options,
    this.onChanged,
    this.onTap,
    this.isSelected = false,
  })  : child = null,
        type = TableCustomCellType.dropdown;

  const TableCustomCell.textField({
    super.key,
    this.value,
    this.onChanged,
    this.onTap,
    this.isSelected = false,
  })  : child = null,
        options = null,
        type = TableCustomCellType.textField;

  final Widget? child;
  final bool isSelected;
  final VoidCallback? onTap;
  final TableCustomCellType type;

  final String? value;
  final List<DropdownMenuItem<String>>? options;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    Border border = Border.all(
      color: specs.borderColor,
      width: specs.borderWidth,
    );

    if (isSelected) {
      border = Border.all(
        color: specs.selectedBorderColor,
        width: specs.selectedBorderWidth,
      );
    }

    EdgeInsets padding = EdgeInsets.only(
      top: max(specs.cellPadding.top - border.top.width, 0),
      bottom: max(specs.cellPadding.bottom - border.bottom.width, 0),
      left: max(specs.cellPadding.left - border.left.width, 0),
      right: max(specs.cellPadding.right - border.right.width, 0),
    );

    if (type.isDropdown) {
      return GestureDetector(
        onTap: onTap,
        child: _TableCustomDropdownCell(
          value: value,
          items: options!,
          onChanged: onChanged,
          padding: padding,
          border: border,
          isSelected: isSelected,
        ),
      );
    }

    if (type.isTextField) {
      return GestureDetector(
        onTap: onTap,
        child: _TableCustomTextFieldCell(
          valeu: value,
          onChanged: onChanged,
          padding: padding,
          border: border,
          isSelected: isSelected,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: specs.minColumnWidth,
        alignment: specs.cellAlignment,
        decoration: BoxDecoration(
          border: border,
        ),
        child: child,
      ),
    );
  }
}

class _TableCustomDropdownCell extends StatelessWidget {
  const _TableCustomDropdownCell({
    required this.padding,
    required this.border,
    required this.items,
    this.value,
    this.onChanged,
    this.isSelected = false,
  });

  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;
  final Border border;
  final EdgeInsets padding;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    Widget child;
    if (isSelected) {
      child = Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButtonFormField(
          focusColor: Colors.transparent,
          autofocus: true,
          items: items,
          onChanged: onChanged,
          iconEnabledColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: padding.left,
              right: padding.right,
            ),
          ),
        ),
      );
    } else {
      child = Padding(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      );
    }

    return Container(
      width: specs.minColumnWidth,
      alignment: specs.cellAlignment,
      decoration: BoxDecoration(
        border: border,
      ),
      child: child,
    );
  }
}

class _TableCustomTextFieldCell extends StatelessWidget {
  const _TableCustomTextFieldCell({
    this.valeu,
    this.onChanged,
    required this.padding,
    required this.border,
    this.isSelected = false,
  });

  final String? valeu;
  final ValueChanged<String>? onChanged;
  final Border border;
  final EdgeInsets padding;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    Widget child;
    if (isSelected) {
      child = TextFormField(
        initialValue: valeu,
        autofocus: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: padding,
        ),
      );
    } else {
      child = Padding(
        padding: padding,
        child: Text(
          valeu ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Container(
      width: specs.minColumnWidth,
      alignment: specs.cellAlignment,
      decoration: BoxDecoration(
        border: border,
      ),
      child: child,
    );
  }
}

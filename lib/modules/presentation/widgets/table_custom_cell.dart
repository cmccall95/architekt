part of 'table_custom.dart';

typedef SelectedCell = ({
  MTO row,
  MTOField column,
});

class TableCustomCell extends StatelessWidget {
  const TableCustomCell({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
  });

  final Widget child;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final specs = TableCustom.of(context);

    var border = Border.all(
      color: specs.borderColor,
      width: specs.borderWidth,
    );

    if (isSelected) {
      border = Border.all(
        color: specs.selectedBorderColor,
        width: specs.selectedBorderWidth,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: specs.cellPadding,
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

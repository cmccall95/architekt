part of '../blueprint_page.dart';

class _EditRegionDialog extends HookWidget {
  const _EditRegionDialog._({
    super.key,
    required this.region,
  });

  final Region region;

  static Future<Region?> show({
    required BuildContext context,
    required Region region,
  }) async {
    final region_ = await showDialog<Region>(
      context: context,
      builder: (context) {
        return _EditRegionDialog._(
          region: region,
        );
      },
    );

    if (region_ is! Region) return null;
    return region_;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a field';
    }

    return null;
  }

  void _deleteFieldChild({
    required int index,
    required List<RoiColumns?> tableFields,
    required ValueChanged<List<RoiColumns?>> onTableFieldsChanged,
    required ValueChanged<bool> onIsTableChanged,
  }) {
    final fields = tableFields.toList();
    fields.removeAt(index);

    if (fields.isEmpty) {
      onIsTableChanged(false);
    }

    onTableFieldsChanged(fields);
  }

  void _validateAndSave({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required RoiColumns? field,
    required List<RoiColumns?> tableFields,
  }) {
    if (!formKey.currentState!.validate()) return;

    final tableFields_ = tableFields.map((e) => e!).toList();
    var region_ = region.copyWith(field: field);
    region_ = region_.divideRegion(tableFields_);

    Navigator.of(context).pop(region_);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final field_ = region.field;
    final tableFields_ = region.divisions.map((e) => e.field).toList();

    final field = useState<RoiColumns?>(field_);
    final tableFields = useState<List<RoiColumns?>>(tableFields_);
    final isTable = useState<bool>(tableFields_.isNotEmpty);

    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _validateAndSave(
            context: context,
            formKey: formKey,
            field: field.value,
            tableFields: tableFields.value,
          ),
          child: const Text('Save'),
        ),
      ],
      title: const Text('Edit Selection'),
      content: SizedBox(
        width: 300,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FieldSelector(
                field: field.value,
                validator: _validator,
                onFieldChanged: (value) {
                  field.value = value;
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 8,
                title: const Text('Table selection?'),
                leading: Checkbox(
                  value: isTable.value,
                  onChanged: (value) {
                    isTable.value = value!;
                    if (value) {
                      tableFields.value = [null];
                    } else {
                      tableFields.value = [];
                    }
                  },
                ),
              ),
              if (isTable.value) ...[
                const Divider(),
                _TableColumns(
                  fields: tableFields.value,
                  validator: _validator,
                  onFieldsChanged: (fields) => tableFields.value = fields,
                  onDeleted: (index) => _deleteFieldChild(
                    index: index,
                    tableFields: tableFields.value,
                    onTableFieldsChanged: (fields) =>
                        tableFields.value = fields,
                    onIsTableChanged: (value) => isTable.value = value,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    tableFields.value = [...tableFields.value, null];
                  },
                  child: const Text('Add field'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TableColumns extends ConsumerWidget {
  const _TableColumns({
    required this.fields,
    required this.onDeleted,
    required this.onFieldsChanged,
    required this.validator,
  });

  final List<RoiColumns?> fields;
  final ValueChanged<int> onDeleted;
  final ValueChanged<List<RoiColumns?>> onFieldsChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const paddingVertical = 8.0;
    const textFieldHeight = 53.0 + paddingVertical * 2;

    const maxHeight = textFieldHeight * 3 + 16;

    return SizedBox(
      height: min(maxHeight, textFieldHeight * fields.length),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: fields.length,
        itemBuilder: (context, index) {
          final field = fields[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingVertical),
            child: FieldSelector(
              field: field,
              validator: validator,
              onFieldChanged: (value) {
                final fields_ = fields.toList();
                fields_[index] = value;
                onFieldsChanged(fields_);
              },
              suffixIcon: GestureDetector(
                onTap: () => onDeleted(index),
                child: const Icon(Icons.close),
              ),
            ),
          );
        },
      ),
    );
  }
}

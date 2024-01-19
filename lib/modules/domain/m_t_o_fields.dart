enum MTOFieldType {
  /// represents a region with a single column
  column,

  /// represents a region with multiple columns
  table,
}

enum MTOField {
  id('id', MTOFieldType.column),
  drawing('drawing', MTOFieldType.column),
  sheet('sheet', MTOFieldType.column),
  lineNumber('line_number', MTOFieldType.column),
  pipeSpec('pipe_spec', MTOFieldType.column),
  paintSpec('paint_spec', MTOFieldType.column),
  insulationSpec('insulation_spec', MTOFieldType.column),
  pwht('pwht', MTOFieldType.column),
  pAndId('p_and_id', MTOFieldType.column),
  area('area', MTOFieldType.column),
  item('item', MTOFieldType.column),
  tag('tag', MTOFieldType.column),
  quantity('quantity', MTOFieldType.column),
  nps('nps', MTOFieldType.column),
  materialDescription('material_description', MTOFieldType.column),
  heatTrace('heat_trace', MTOFieldType.column),
  insulationType('insulation_type', MTOFieldType.column),
  insulationThickness('insulation_thickness', MTOFieldType.column),
  processLineList('process_line_list', MTOFieldType.column),
  pos('pos', MTOFieldType.column),
  ident('ident', MTOFieldType.column),
  npd('npd', MTOFieldType.column),
  documents('documents', MTOFieldType.column),
  ptnd('ptnd', MTOFieldType.column),
  size('size', MTOFieldType.column),
  bom('bom', MTOFieldType.table);

  const MTOField(this.value, this.type);

  final String value;
  final MTOFieldType type;

  static List<MTOField> get sortSingleFields {
    final values = MTOField.values.where((e) => e.isColumn).toList();
    values.sort((a, b) => a.name.compareTo(b.name));
    return values;
  }

  static List<MTOField> get sortMultiFields {
    final values = MTOField.values.where((e) => e.isTable).toList();
    values.sort((a, b) => a.name.compareTo(b.name));
    return values;
  }

  String get name {
    return switch (this) {
      MTOField.id => 'ID',
      MTOField.drawing => 'Drawing',
      MTOField.sheet => 'Sheet',
      MTOField.lineNumber => 'Line Number',
      MTOField.pipeSpec => 'Pipe Spec',
      MTOField.paintSpec => 'Paint Spec',
      MTOField.insulationSpec => 'Insulation Spec',
      MTOField.pwht => 'PWHT',
      MTOField.pAndId => 'P&ID',
      MTOField.area => 'Area',
      MTOField.item => 'Item',
      MTOField.tag => 'Tag',
      MTOField.quantity => 'Quantity',
      MTOField.nps => 'NPS',
      MTOField.materialDescription => 'Material Description',
      MTOField.heatTrace => 'Heat Trace',
      MTOField.insulationType => 'Insulation Type',
      MTOField.insulationThickness => 'Insulation Thickness',
      MTOField.processLineList => 'Process Line List',
      MTOField.documents => 'Documents',
      MTOField.pos => 'POS',
      MTOField.ident => 'IDENT',
      MTOField.npd => 'NPD',
      MTOField.ptnd => 'PTND',
      MTOField.size => 'Size',
      MTOField.bom => 'BOM',
    };
  }

  bool get isColumn => switch (type) {
        MTOFieldType.column => true,
        _ => false,
      };

  bool get isTable => switch (type) {
        MTOFieldType.table => true,
        _ => false,
      };
}

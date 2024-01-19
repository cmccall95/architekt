enum MTOField {
  id('id'),
  drawing('drawing'),
  sheet('sheet'),
  lineNumber('line_number'),
  pipeSpec('pipe_spec'),
  paintSpec('paint_spec'),
  insulationSpec('insulation_spec'),
  pwht('pwht'),
  pAndId('p_and_id'),
  area('area'),
  item('item'),
  tag('tag'),
  quantity('quantity'),
  nps('nps'),
  materialDescription('material_description'),
  heatTrace('heat_trace'),
  insulationType('insulation_type'),
  insulationThickness('insulation_thickness'),
  processLineList('process_line_list'),
  pos('pos'),
  ident('ident'),
  npd('npd'),
  documents('documents'),
  ptnd('ptnd'),
  size('size'),
  bom('bom');

  const MTOField(this.value);

  final String value;

  static List<MTOField> get valuesSorted {
    final values_ = values.toList();
    values_.sort((a, b) => a.name.compareTo(b.name));
    return values_;
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
}

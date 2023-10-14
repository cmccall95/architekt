enum ColumnName {
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
  documents('documents');

  const ColumnName(this.value);
  final String value;

  String get name {
    return switch (this) {
      ColumnName.id => 'ID',
      ColumnName.drawing => 'Drawing',
      ColumnName.sheet => 'Sheet',
      ColumnName.lineNumber => 'Line Number',
      ColumnName.pipeSpec => 'Pipe Spec',
      ColumnName.paintSpec => 'Paint Spec',
      ColumnName.insulationSpec => 'Insulation Spec',
      ColumnName.pwht => 'PWHT',
      ColumnName.pAndId => 'P&ID',
      ColumnName.area => 'Area',
      ColumnName.item => 'Item',
      ColumnName.tag => 'Tag',
      ColumnName.quantity => 'Quantity',
      ColumnName.nps => 'NPS',
      ColumnName.materialDescription => 'Material Description',
      ColumnName.heatTrace => 'Heat Trace',
      ColumnName.insulationType => 'Insulation Type',
      ColumnName.insulationThickness => 'Insulation Thickness',
      ColumnName.processLineList => 'Process Line List',
      ColumnName.documents => 'Documents',
    };
  }
}

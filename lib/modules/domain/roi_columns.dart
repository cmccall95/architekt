enum RoiColumns {
  drawing(
    fieldId: 'drawing',
    defaultName: 'Drawing',
  ),
  sheet(
    fieldId: 'sheet',
    defaultName: 'Sheet #',
  ),
  ofSheet(
    fieldId: 'of_sheet',
    defaultName: 'of Sheet #',
  ),
  lineNumber(
    fieldId: 'line_number',
    defaultName: 'Line Number',
  ),
  pipeSpec(
    fieldId: 'pipe_spec',
    defaultName: 'Pipe Spec',
  ),
  insulationSpec(
    fieldId: 'insulation_spec',
    defaultName: 'Insulation Spec',
  ),
  pwht(
    fieldId: 'pwht',
    defaultName: 'PWHT',
  ),
  pAndId(
    fieldId: 'p_and_id',
    defaultName: 'P&ID',
  ),
  area(
    fieldId: 'area',
    defaultName: 'Area',
  ),
  unit(
    fieldId: 'unit',
    defaultName: 'Unit',
  ),
  item(
    fieldId: 'item',
    defaultName: 'Item',
  ),
  tag(
    fieldId: 'tag',
    defaultName: 'Tag',
  ),
  quantity(
    fieldId: 'quantity',
    defaultName: 'Quantity',
  ),
  npsOd(
    fieldId: 'nps_od',
    defaultName: 'NPS (OD)',
  ),
  npsId(
    fieldId: 'nps_id',
    defaultName: 'NPS (ID)',
  ),
  materialDescription(
    fieldId: 'material_description',
    defaultName: 'Material Description',
  ),
  heatTrace(
    fieldId: 'heat_trace',
    defaultName: 'Heat Trace',
  ),
  insulationThickness(
    fieldId: 'insulation_thickness',
    defaultName: 'Insulation Thickness',
  ),
  clientDocumentId(
    fieldId: 'client_document_id',
    defaultName: 'Client Document ID',
  ),
  coordinate(
    fieldId: 'coordinate',
    defaultName: 'Coordinate',
  ),
  cutPieceNo(
    fieldId: 'cut_piece_no',
    defaultName: 'Cut Piece No',
  ),
  designCode(
    fieldId: 'design_code',
    defaultName: 'Design Code',
  ),
  dp1(
    fieldId: 'dp1',
    defaultName: 'Design Pressure 1',
  ),
  dp2(
    fieldId: 'dp2',
    defaultName: 'Design Pressure 2',
  ),
  dt1(
    fieldId: 'dt1',
    defaultName: 'Design Temp. 1',
  ),
  dt2(
    fieldId: 'dt2',
    defaultName: 'Design Temp. 2',
  ),
  document(
    fieldId: 'document',
    defaultName: 'Document #',
  ),
  documentDescription(
    fieldId: 'document_description',
    defaultName: 'Document Description',
  ),
  documentId(
    fieldId: 'document_id',
    defaultName: 'Document ID',
  ),
  documentTitle(
    fieldId: 'document_title',
    defaultName: 'Document Title',
  ),
  elevation(
    fieldId: 'elevation',
    defaultName: 'Elevation',
  ),
  ident(
    fieldId: 'ident',
    defaultName: 'IDENT',
  ),
  length(
    fieldId: 'length',
    defaultName: 'Length',
  ),
  mediumCode(
    fieldId: 'medium_code',
    defaultName: 'Medium Code',
  ),
  op1(
    fieldId: 'op1',
    defaultName: 'Operating Pressure 1',
  ),
  op2(
    fieldId: 'op2',
    defaultName: 'Operating Pressure 2',
  ),
  opt1(
    fieldId: 'opt1',
    defaultName: 'Operating Temp. 1',
  ),
  opt2(
    fieldId: 'opt2',
    defaultName: 'Operating Temp. 2',
  ),
  paintSpec(
    fieldId: 'paint_spec',
    defaultName: 'Paint Spec',
  ),
  pipeStandard(
    fieldId: 'pipe_standard',
    defaultName: 'Pipe Standard',
  ),
  pos(
    fieldId: 'pos',
    defaultName: 'POS',
  ),
  processLineList(
    fieldId: 'process_line_list',
    defaultName: 'Process Line List',
  ),
  processUnit(
    fieldId: 'process_unit',
    defaultName: 'Process Unit',
  ),
  projectId(
    fieldId: 'project_id',
    defaultName: 'Project ID',
  ),
  projectName(
    fieldId: 'project_name',
    defaultName: 'Project Name',
  ),
  revision(
    fieldId: 'revision',
    defaultName: 'Revision',
  ),
  sequence(
    fieldId: 'sequence',
    defaultName: 'Sequence #',
  ),
  service(
    fieldId: 'service',
    defaultName: 'Service',
  ),
  spoolNumber(
    fieldId: 'spool_number',
    defaultName: 'Spool Number',
  ),
  system(
    fieldId: 'system',
    defaultName: 'System',
  ),
  vendorDocumentId(
    fieldId: 'vendor_document_id',
    defaultName: 'Vendor Document ID',
  ),
  weldId(
    fieldId: 'weld_id',
    defaultName: 'Weld ID',
  ),
  xray(
    fieldId: 'xray',
    defaultName: 'X-Ray',
  ),
  bom(
    fieldId: 'bom',
    defaultName: 'BOM',
  ),
  spec(
    fieldId: 'spec',
    defaultName: 'Spec',
  ),
  fab(
    fieldId: 'fab',
    defaultName: 'Fab',
  ),
  spoon(
    fieldId: 'spoon',
    defaultName: 'Spoon',
  ),
  notesComments(
    fieldId: 'notes_comments',
    defaultName: 'Notes/Comments',
  ),
  status(
    fieldId: 'status',
    defaultName: 'Status',
  ),
  ;

  const RoiColumns({
    required this.fieldId,
    required this.defaultName,
  });

  final String fieldId;
  final String defaultName;

  static RoiColumns fromString(String fieldId) {
    return switch (fieldId) {
      'drawing' => RoiColumns.drawing,
      'sheet' => RoiColumns.sheet,
      'of_sheet' => RoiColumns.ofSheet,
      'line_number' => RoiColumns.lineNumber,
      'pipe_spec' => RoiColumns.pipeSpec,
      'insulation_spec' => RoiColumns.insulationSpec,
      'pwht' => RoiColumns.pwht,
      'p_and_id' => RoiColumns.pAndId,
      'area' => RoiColumns.area,
      'unit' => RoiColumns.unit,
      'item' => RoiColumns.item,
      'tag' => RoiColumns.tag,
      'quantity' => RoiColumns.quantity,
      'nps_od' => RoiColumns.npsOd,
      'nps_id' => RoiColumns.npsId,
      'material_description' => RoiColumns.materialDescription,
      'heat_trace' => RoiColumns.heatTrace,
      'insulation_thickness' => RoiColumns.insulationThickness,
      'client_document_id' => RoiColumns.clientDocumentId,
      'coordinate' => RoiColumns.coordinate,
      'cut_piece_no' => RoiColumns.cutPieceNo,
      'design_code' => RoiColumns.designCode,
      'dp1' => RoiColumns.dp1,
      'dp2' => RoiColumns.dp2,
      'dt1' => RoiColumns.dt1,
      'dt2' => RoiColumns.dt2,
      'document' => RoiColumns.document,
      'document_description' => RoiColumns.documentDescription,
      'document_id' => RoiColumns.documentId,
      'document_title' => RoiColumns.documentTitle,
      'elevation' => RoiColumns.elevation,
      'ident' => RoiColumns.ident,
      'length' => RoiColumns.length,
      'medium_code' => RoiColumns.mediumCode,
      'op1' => RoiColumns.op1,
      'op2' => RoiColumns.op2,
      'opt1' => RoiColumns.opt1,
      'opt2' => RoiColumns.opt2,
      'paint_spec' => RoiColumns.paintSpec,
      'pipe_standard' => RoiColumns.pipeStandard,
      'pos' => RoiColumns.pos,
      'process_line_list' => RoiColumns.processLineList,
      'process_unit' => RoiColumns.processUnit,
      'project_id' => RoiColumns.projectId,
      'project_name' => RoiColumns.projectName,
      'revision' => RoiColumns.revision,
      'sequence' => RoiColumns.sequence,
      'service' => RoiColumns.service,
      'spool_number' => RoiColumns.spoolNumber,
      'system' => RoiColumns.system,
      'vendor_document_id' => RoiColumns.vendorDocumentId,
      'weld_id' => RoiColumns.weldId,
      'xray' => RoiColumns.xray,
      'bom' => RoiColumns.bom,
      'spec' => RoiColumns.spec,
      'fab' => RoiColumns.fab,
      'spoon' => RoiColumns.spoon,
      'notes_comments' => RoiColumns.notesComments,
      'status' => RoiColumns.status,
      _ => RoiColumns.drawing,
    };
  }
}

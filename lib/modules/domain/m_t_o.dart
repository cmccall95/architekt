import 'm_t_o_fields.dart';

class MTO {
  MTO({
    required this.databaseId,
    this.databaseCount,
    this.id,
    this.drawing,
    this.sheet,
    this.lineNumber,
    this.pipeSpec,
    this.paintSpec,
    this.insulationSpec,
    this.pwht,
    this.pAndId,
    this.area,
    this.item,
    this.tag,
    this.quantity,
    this.nps,
    this.materialDescription,
    this.heatTrace,
    this.insulationType,
    this.insulationThickness,
    this.processLineList,
    this.documents,
    this.pos,
    this.ident,
    this.npd,
    this.ptnd,
    this.size,
  });

  factory MTO.fromJson(Map<String, dynamic> json) => MTO(
        databaseId: json['database_id'],
        databaseCount: json['database_count'],
        id: json[MTOField.id.value],
        drawing: json[MTOField.drawing.value],
        sheet: json[MTOField.sheet.value]?.toString(),
        lineNumber: json[MTOField.lineNumber.value]?.toString(),
        pipeSpec: json[MTOField.pipeSpec.value],
        paintSpec: json[MTOField.paintSpec.value],
        insulationSpec: json[MTOField.insulationSpec.value],
        pwht: json[MTOField.pwht.value],
        pAndId: json[MTOField.pAndId.value],
        area: json[MTOField.area.value],
        item: json[MTOField.item.value],
        tag: json[MTOField.tag.value],
        quantity: json[MTOField.quantity.value],
        nps: json[MTOField.nps.value],
        materialDescription: json[MTOField.materialDescription.value],
        heatTrace: json[MTOField.heatTrace.value],
        insulationType: json[MTOField.insulationType.value],
        insulationThickness: json[MTOField.insulationThickness.value],
        processLineList: json[MTOField.processLineList.value],
        documents: json[MTOField.documents.value],
        pos: json[MTOField.pos.value],
        ident: json[MTOField.ident.value],
        npd: json[MTOField.npd.value],
        ptnd: json[MTOField.ptnd.value],
        size: json[MTOField.size.value],
      );

  /// local database id
  final int? databaseId;

  /// sum of grouping rows
  final int? databaseCount;

  final String? id;
  final String? drawing;
  final String? sheet;
  final String? lineNumber;
  final String? pipeSpec;
  final String? paintSpec;
  final String? insulationSpec;
  final String? pwht;
  final String? pAndId;
  final String? area;
  final String? item;
  final String? tag;
  final String? quantity;
  final String? nps;
  final String? materialDescription;
  final String? heatTrace;
  final String? insulationType;
  final String? insulationThickness;
  final String? processLineList;
  final String? documents;
  final String? pos;
  final String? ident;
  final String? npd;
  final String? ptnd;
  final String? size;

  String? getValueFromField(MTOField field) {
    final value = switch (field) {
      MTOField.id => id,
      MTOField.drawing => drawing,
      MTOField.sheet => sheet,
      MTOField.lineNumber => lineNumber,
      MTOField.pipeSpec => pipeSpec,
      MTOField.paintSpec => paintSpec,
      MTOField.insulationSpec => insulationSpec,
      MTOField.pwht => pwht,
      MTOField.pAndId => pAndId,
      MTOField.area => area,
      MTOField.item => item,
      MTOField.tag => tag,
      MTOField.quantity => quantity,
      MTOField.nps => nps,
      MTOField.materialDescription => materialDescription,
      MTOField.heatTrace => heatTrace,
      MTOField.insulationType => insulationType,
      MTOField.insulationThickness => insulationThickness,
      MTOField.processLineList => processLineList,
      MTOField.documents => documents,
      MTOField.pos => pos,
      MTOField.ident => ident,
      MTOField.npd => npd,
      MTOField.ptnd => ptnd,
      MTOField.size => size,
    };

    return value;
  }

  Map<String, dynamic> toJson() {
    return {
      'database_id': databaseId,
      'database_count': databaseCount,
      MTOField.id.value: id,
      MTOField.drawing.value: drawing,
      MTOField.sheet.value: sheet,
      MTOField.lineNumber.value: lineNumber,
      MTOField.pipeSpec.value: pipeSpec,
      MTOField.paintSpec.value: paintSpec,
      MTOField.insulationSpec.value: insulationSpec,
      MTOField.pwht.value: pwht,
      MTOField.pAndId.value: pAndId,
      MTOField.area.value: area,
      MTOField.item.value: item,
      MTOField.tag.value: tag,
      MTOField.quantity.value: quantity,
      MTOField.nps.value: nps,
      MTOField.materialDescription.value: materialDescription,
      MTOField.heatTrace.value: heatTrace,
      MTOField.insulationType.value: insulationType,
      MTOField.insulationThickness.value: insulationThickness,
      MTOField.processLineList.value: processLineList,
      MTOField.documents.value: documents,
      MTOField.pos.value: pos,
      MTOField.ident.value: ident,
      MTOField.npd.value: npd,
      MTOField.ptnd.value: ptnd,
      MTOField.size.value: size,
    };
  }
}

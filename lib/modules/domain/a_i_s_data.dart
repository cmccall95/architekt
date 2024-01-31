import 'package:equatable/equatable.dart';

import 'a_i_s_field.dart';

class AISData extends Equatable {
  const AISData({
    this.drawing,
    this.sheet,
    this.ofSheet,
    this.lineNumber,
    this.pipeSpec,
    this.insulationSpec,
    this.pwht,
    this.pAndId,
    this.area,
    this.unit,
    this.item,
    this.tag,
    this.quantity,
    this.npsOd,
    this.npsId,
    this.materialDescription,
    this.heatTrace,
    this.insulationThickness,
    this.clientDocumentId,
    this.coordinate,
    this.cutPieceNo,
    this.designCode,
    this.dp1,
    this.dp2,
    this.dt1,
    this.dt2,
    this.document,
    this.documentDescription,
    this.documentId,
    this.documentTitle,
    this.elevation,
    this.ident,
    this.length,
    this.mediumCode,
    this.op1,
    this.op2,
    this.opt1,
    this.opt2,
    this.paintSpec,
    this.pipeStandard,
    this.pos,
    this.processLineList,
    this.processUnit,
    this.projectId,
    this.projectName,
    this.revision,
    this.sequence,
    this.service,
    this.spoolNumber,
    this.system,
    this.vendorDocumentId,
    this.weldId,
    this.xray,
    this.sysBuild,
    this.sysFilename,
    this.sysPath,
  });

  final String? drawing;
  final String? sheet;
  final String? ofSheet;
  final String? lineNumber;
  final String? pipeSpec;
  final String? insulationSpec;
  final String? pwht;
  final String? pAndId;
  final String? area;
  final String? unit;
  final String? item;
  final String? tag;
  final String? quantity;
  final String? npsOd;
  final String? npsId;
  final String? materialDescription;
  final String? heatTrace;
  final String? insulationThickness;
  final String? clientDocumentId;
  final String? coordinate;
  final String? cutPieceNo;
  final String? designCode;
  final String? dp1;
  final String? dp2;
  final String? dt1;
  final String? dt2;
  final String? document;
  final String? documentDescription;
  final String? documentId;
  final String? documentTitle;
  final String? elevation;
  final String? ident;
  final String? length;
  final String? mediumCode;
  final String? op1;
  final String? op2;
  final String? opt1;
  final String? opt2;
  final String? paintSpec;
  final String? pipeStandard;
  final String? pos;
  final String? processLineList;
  final String? processUnit;
  final String? projectId;
  final String? projectName;
  final String? revision;
  final String? sequence;
  final String? service;
  final String? spoolNumber;
  final String? system;
  final String? vendorDocumentId;
  final String? weldId;
  final String? xray;
  final String? sysBuild;
  final String? sysFilename;
  final String? sysPath;

  String? dataFromField(AISField field) {
    return switch (field) {
      AISField.drawing => drawing,
      AISField.sheet => sheet,
      AISField.ofSheet => ofSheet,
      AISField.lineNumber => lineNumber,
      AISField.pipeSpec => pipeSpec,
      AISField.insulationSpec => insulationSpec,
      AISField.pwht => pwht,
      AISField.pAndId => pAndId,
      AISField.area => area,
      AISField.unit => unit,
      AISField.item => item,
      AISField.tag => tag,
      AISField.quantity => quantity,
      AISField.npsOd => npsOd,
      AISField.npsId => npsId,
      AISField.materialDescription => materialDescription,
      AISField.heatTrace => heatTrace,
      AISField.insulationThickness => insulationThickness,
      AISField.clientDocumentId => clientDocumentId,
      AISField.coordinate => coordinate,
      AISField.cutPieceNo => cutPieceNo,
      AISField.designCode => designCode,
      AISField.dp1 => dp1,
      AISField.dp2 => dp2,
      AISField.dt1 => dt1,
      AISField.dt2 => dt2,
      AISField.document => document,
      AISField.documentDescription => documentDescription,
      AISField.documentId => documentId,
      AISField.documentTitle => documentTitle,
      AISField.elevation => elevation,
      AISField.ident => ident,
      AISField.length => length,
      AISField.mediumCode => mediumCode,
      AISField.op1 => op1,
      AISField.op2 => op2,
      AISField.opt1 => opt1,
      AISField.opt2 => opt2,
      AISField.paintSpec => paintSpec,
      AISField.pipeStandard => pipeStandard,
      AISField.pos => pos,
      AISField.processLineList => processLineList,
      AISField.processUnit => processUnit,
      AISField.projectId => projectId,
      AISField.projectName => projectName,
      AISField.revision => revision,
      AISField.sequence => sequence,
      AISField.service => service,
      AISField.spoolNumber => spoolNumber,
      AISField.system => system,
      AISField.vendorDocumentId => vendorDocumentId,
      AISField.weldId => weldId,
      AISField.xray => xray,
      AISField.sysBuild => sysBuild,
      AISField.sysFilename => sysFilename,
      AISField.sysPath => sysPath,
      AISField.bom => null,
      AISField.fab => null,
      AISField.spec => null,
    };
  }

  static AISData fromJson(Map<String, dynamic> json) {
    return AISData(
      drawing: json[AISField.drawing.fieldId],
      sheet: json[AISField.sheet.fieldId],
      ofSheet: json[AISField.ofSheet.fieldId],
      lineNumber: json[AISField.lineNumber.fieldId],
      pipeSpec: json[AISField.pipeSpec.fieldId],
      insulationSpec: json[AISField.insulationSpec.fieldId],
      pwht: json[AISField.pwht.fieldId],
      pAndId: json[AISField.pAndId.fieldId],
      area: json[AISField.area.fieldId],
      unit: json[AISField.unit.fieldId],
      item: json[AISField.item.fieldId],
      tag: json[AISField.tag.fieldId],
      quantity: json[AISField.quantity.fieldId],
      npsOd: json[AISField.npsOd.fieldId],
      npsId: json[AISField.npsId.fieldId],
      materialDescription: json[AISField.materialDescription.fieldId],
      heatTrace: json[AISField.heatTrace.fieldId],
      insulationThickness: json[AISField.insulationThickness.fieldId],
      clientDocumentId: json[AISField.clientDocumentId.fieldId],
      coordinate: json[AISField.coordinate.fieldId],
      cutPieceNo: json[AISField.cutPieceNo.fieldId],
      designCode: json[AISField.designCode.fieldId],
      dp1: json[AISField.dp1.fieldId],
      dp2: json[AISField.dp2.fieldId],
      dt1: json[AISField.dt1.fieldId],
      dt2: json[AISField.dt2.fieldId],
      document: json[AISField.document.fieldId],
      documentDescription: json[AISField.documentDescription.fieldId],
      documentId: json[AISField.documentId.fieldId],
      documentTitle: json[AISField.documentTitle.fieldId],
      elevation: json[AISField.elevation.fieldId],
      ident: json[AISField.ident.fieldId],
      length: json[AISField.length.fieldId],
      mediumCode: json[AISField.mediumCode.fieldId],
      op1: json[AISField.op1.fieldId],
      op2: json[AISField.op2.fieldId],
      opt1: json[AISField.opt1.fieldId],
      opt2: json[AISField.opt2.fieldId],
      paintSpec: json[AISField.paintSpec.fieldId],
      pipeStandard: json[AISField.pipeStandard.fieldId],
      pos: json[AISField.pos.fieldId],
      processLineList: json[AISField.processLineList.fieldId],
      processUnit: json[AISField.processUnit.fieldId],
      projectId: json[AISField.projectId.fieldId],
      projectName: json[AISField.projectName.fieldId],
      revision: json[AISField.revision.fieldId],
      sequence: json[AISField.sequence.fieldId],
      service: json[AISField.service.fieldId],
      spoolNumber: json[AISField.spoolNumber.fieldId],
      system: json[AISField.system.fieldId],
      vendorDocumentId: json[AISField.vendorDocumentId.fieldId],
      weldId: json[AISField.weldId.fieldId],
      xray: json[AISField.xray.fieldId],
      sysBuild: json[AISField.sysBuild.fieldId],
      sysFilename: json[AISField.sysFilename.fieldId],
      sysPath: json[AISField.sysPath.fieldId],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      AISField.drawing.fieldId: drawing,
      AISField.sheet.fieldId: sheet,
      AISField.ofSheet.fieldId: ofSheet,
      AISField.lineNumber.fieldId: lineNumber,
      AISField.pipeSpec.fieldId: pipeSpec,
      AISField.insulationSpec.fieldId: insulationSpec,
      AISField.pwht.fieldId: pwht,
      AISField.pAndId.fieldId: pAndId,
      AISField.area.fieldId: area,
      AISField.unit.fieldId: unit,
      AISField.item.fieldId: item,
      AISField.tag.fieldId: tag,
      AISField.quantity.fieldId: quantity,
      AISField.npsOd.fieldId: npsOd,
      AISField.npsId.fieldId: npsId,
      AISField.materialDescription.fieldId: materialDescription,
      AISField.heatTrace.fieldId: heatTrace,
      AISField.insulationThickness.fieldId: insulationThickness,
      AISField.clientDocumentId.fieldId: clientDocumentId,
      AISField.coordinate.fieldId: coordinate,
      AISField.cutPieceNo.fieldId: cutPieceNo,
      AISField.designCode.fieldId: designCode,
      AISField.dp1.fieldId: dp1,
      AISField.dp2.fieldId: dp2,
      AISField.dt1.fieldId: dt1,
      AISField.dt2.fieldId: dt2,
      AISField.document.fieldId: document,
      AISField.documentDescription.fieldId: documentDescription,
      AISField.documentId.fieldId: documentId,
      AISField.documentTitle.fieldId: documentTitle,
      AISField.elevation.fieldId: elevation,
      AISField.ident.fieldId: ident,
      AISField.length.fieldId: length,
      AISField.mediumCode.fieldId: mediumCode,
      AISField.op1.fieldId: op1,
      AISField.op2.fieldId: op2,
      AISField.opt1.fieldId: opt1,
      AISField.opt2.fieldId: opt2,
      AISField.paintSpec.fieldId: paintSpec,
      AISField.pipeStandard.fieldId: pipeStandard,
      AISField.pos.fieldId: pos,
      AISField.processLineList.fieldId: processLineList,
      AISField.processUnit.fieldId: processUnit,
      AISField.projectId.fieldId: projectId,
      AISField.projectName.fieldId: projectName,
      AISField.revision.fieldId: revision,
      AISField.sequence.fieldId: sequence,
      AISField.service.fieldId: service,
      AISField.spoolNumber.fieldId: spoolNumber,
      AISField.system.fieldId: system,
      AISField.vendorDocumentId.fieldId: vendorDocumentId,
      AISField.weldId.fieldId: weldId,
      AISField.xray.fieldId: xray,
      AISField.sysBuild.fieldId: sysBuild,
      AISField.sysFilename.fieldId: sysFilename,
      AISField.sysPath.fieldId: sysPath,
    };
  }

  @override
  List<Object?> get props {
    return <Object?>[
      drawing,
      sheet,
      ofSheet,
      lineNumber,
      pipeSpec,
      insulationSpec,
      pwht,
      pAndId,
      area,
      unit,
      item,
      tag,
      quantity,
      npsOd,
      npsId,
      materialDescription,
      heatTrace,
      insulationThickness,
      clientDocumentId,
      coordinate,
      cutPieceNo,
      designCode,
      dp1,
      dp2,
      dt1,
      dt2,
      document,
      documentDescription,
      documentId,
      documentTitle,
      elevation,
      ident,
      length,
      mediumCode,
      op1,
      op2,
      opt1,
      opt2,
      paintSpec,
      pipeStandard,
      pos,
      processLineList,
      processUnit,
      projectId,
      projectName,
      revision,
      sequence,
      service,
      spoolNumber,
      system,
      vendorDocumentId,
      weldId,
      xray,
      sysBuild,
      sysFilename,
      sysPath,
    ];
  }

  @override
  bool get stringify => true;
}

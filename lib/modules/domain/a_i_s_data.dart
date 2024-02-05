import 'package:equatable/equatable.dart';

import 'mto_columns.dart';

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

  String? dataFromField(MtoColumns field) {
    return switch (field) {
      MtoColumns.drawing => drawing,
      MtoColumns.sheet => sheet,
      MtoColumns.ofSheet => ofSheet,
      MtoColumns.lineNumber => lineNumber,
      MtoColumns.pipeSpec => pipeSpec,
      MtoColumns.insulationSpec => insulationSpec,
      MtoColumns.pwht => pwht,
      MtoColumns.pAndId => pAndId,
      MtoColumns.area => area,
      MtoColumns.unit => unit,
      MtoColumns.item => item,
      MtoColumns.tag => tag,
      MtoColumns.quantity => quantity,
      MtoColumns.npsOd => npsOd,
      MtoColumns.npsId => npsId,
      MtoColumns.materialDescription => materialDescription,
      MtoColumns.heatTrace => heatTrace,
      MtoColumns.insulationThickness => insulationThickness,
      MtoColumns.clientDocumentId => clientDocumentId,
      MtoColumns.coordinate => coordinate,
      MtoColumns.cutPieceNo => cutPieceNo,
      MtoColumns.designCode => designCode,
      MtoColumns.dp1 => dp1,
      MtoColumns.dp2 => dp2,
      MtoColumns.dt1 => dt1,
      MtoColumns.dt2 => dt2,
      MtoColumns.document => document,
      MtoColumns.documentDescription => documentDescription,
      MtoColumns.documentId => documentId,
      MtoColumns.documentTitle => documentTitle,
      MtoColumns.elevation => elevation,
      MtoColumns.ident => ident,
      MtoColumns.length => length,
      MtoColumns.mediumCode => mediumCode,
      MtoColumns.op1 => op1,
      MtoColumns.op2 => op2,
      MtoColumns.opt1 => opt1,
      MtoColumns.opt2 => opt2,
      MtoColumns.paintSpec => paintSpec,
      MtoColumns.pipeStandard => pipeStandard,
      MtoColumns.pos => pos,
      MtoColumns.processLineList => processLineList,
      MtoColumns.processUnit => processUnit,
      MtoColumns.projectId => projectId,
      MtoColumns.projectName => projectName,
      MtoColumns.revision => revision,
      MtoColumns.sequence => sequence,
      MtoColumns.service => service,
      MtoColumns.spoolNumber => spoolNumber,
      MtoColumns.system => system,
      MtoColumns.vendorDocumentId => vendorDocumentId,
      MtoColumns.weldId => weldId,
      MtoColumns.xray => xray,
      MtoColumns.sysBuild => sysBuild,
      MtoColumns.sysFilename => sysFilename,
      MtoColumns.sysPath => sysPath,
    };
  }

  static AISData fromJson(Map<String, dynamic> json) {
    return AISData(
      drawing: json[MtoColumns.drawing.fieldId],
      sheet: json[MtoColumns.sheet.fieldId],
      ofSheet: json[MtoColumns.ofSheet.fieldId],
      lineNumber: json[MtoColumns.lineNumber.fieldId],
      pipeSpec: json[MtoColumns.pipeSpec.fieldId],
      insulationSpec: json[MtoColumns.insulationSpec.fieldId],
      pwht: json[MtoColumns.pwht.fieldId],
      pAndId: json[MtoColumns.pAndId.fieldId],
      area: json[MtoColumns.area.fieldId],
      unit: json[MtoColumns.unit.fieldId],
      item: json[MtoColumns.item.fieldId],
      tag: json[MtoColumns.tag.fieldId],
      quantity: json[MtoColumns.quantity.fieldId],
      npsOd: json[MtoColumns.npsOd.fieldId],
      npsId: json[MtoColumns.npsId.fieldId],
      materialDescription: json[MtoColumns.materialDescription.fieldId],
      heatTrace: json[MtoColumns.heatTrace.fieldId],
      insulationThickness: json[MtoColumns.insulationThickness.fieldId],
      clientDocumentId: json[MtoColumns.clientDocumentId.fieldId],
      coordinate: json[MtoColumns.coordinate.fieldId],
      cutPieceNo: json[MtoColumns.cutPieceNo.fieldId],
      designCode: json[MtoColumns.designCode.fieldId],
      dp1: json[MtoColumns.dp1.fieldId],
      dp2: json[MtoColumns.dp2.fieldId],
      dt1: json[MtoColumns.dt1.fieldId],
      dt2: json[MtoColumns.dt2.fieldId],
      document: json[MtoColumns.document.fieldId],
      documentDescription: json[MtoColumns.documentDescription.fieldId],
      documentId: json[MtoColumns.documentId.fieldId],
      documentTitle: json[MtoColumns.documentTitle.fieldId],
      elevation: json[MtoColumns.elevation.fieldId],
      ident: json[MtoColumns.ident.fieldId],
      length: json[MtoColumns.length.fieldId],
      mediumCode: json[MtoColumns.mediumCode.fieldId],
      op1: json[MtoColumns.op1.fieldId],
      op2: json[MtoColumns.op2.fieldId],
      opt1: json[MtoColumns.opt1.fieldId],
      opt2: json[MtoColumns.opt2.fieldId],
      paintSpec: json[MtoColumns.paintSpec.fieldId],
      pipeStandard: json[MtoColumns.pipeStandard.fieldId],
      pos: json[MtoColumns.pos.fieldId],
      processLineList: json[MtoColumns.processLineList.fieldId],
      processUnit: json[MtoColumns.processUnit.fieldId],
      projectId: json[MtoColumns.projectId.fieldId],
      projectName: json[MtoColumns.projectName.fieldId],
      revision: json[MtoColumns.revision.fieldId],
      sequence: json[MtoColumns.sequence.fieldId],
      service: json[MtoColumns.service.fieldId],
      spoolNumber: json[MtoColumns.spoolNumber.fieldId],
      system: json[MtoColumns.system.fieldId],
      vendorDocumentId: json[MtoColumns.vendorDocumentId.fieldId],
      weldId: json[MtoColumns.weldId.fieldId],
      xray: json[MtoColumns.xray.fieldId],
      sysBuild: json[MtoColumns.sysBuild.fieldId],
      sysFilename: json[MtoColumns.sysFilename.fieldId],
      sysPath: json[MtoColumns.sysPath.fieldId],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      MtoColumns.drawing.fieldId: drawing,
      MtoColumns.sheet.fieldId: sheet,
      MtoColumns.ofSheet.fieldId: ofSheet,
      MtoColumns.lineNumber.fieldId: lineNumber,
      MtoColumns.pipeSpec.fieldId: pipeSpec,
      MtoColumns.insulationSpec.fieldId: insulationSpec,
      MtoColumns.pwht.fieldId: pwht,
      MtoColumns.pAndId.fieldId: pAndId,
      MtoColumns.area.fieldId: area,
      MtoColumns.unit.fieldId: unit,
      MtoColumns.item.fieldId: item,
      MtoColumns.tag.fieldId: tag,
      MtoColumns.quantity.fieldId: quantity,
      MtoColumns.npsOd.fieldId: npsOd,
      MtoColumns.npsId.fieldId: npsId,
      MtoColumns.materialDescription.fieldId: materialDescription,
      MtoColumns.heatTrace.fieldId: heatTrace,
      MtoColumns.insulationThickness.fieldId: insulationThickness,
      MtoColumns.clientDocumentId.fieldId: clientDocumentId,
      MtoColumns.coordinate.fieldId: coordinate,
      MtoColumns.cutPieceNo.fieldId: cutPieceNo,
      MtoColumns.designCode.fieldId: designCode,
      MtoColumns.dp1.fieldId: dp1,
      MtoColumns.dp2.fieldId: dp2,
      MtoColumns.dt1.fieldId: dt1,
      MtoColumns.dt2.fieldId: dt2,
      MtoColumns.document.fieldId: document,
      MtoColumns.documentDescription.fieldId: documentDescription,
      MtoColumns.documentId.fieldId: documentId,
      MtoColumns.documentTitle.fieldId: documentTitle,
      MtoColumns.elevation.fieldId: elevation,
      MtoColumns.ident.fieldId: ident,
      MtoColumns.length.fieldId: length,
      MtoColumns.mediumCode.fieldId: mediumCode,
      MtoColumns.op1.fieldId: op1,
      MtoColumns.op2.fieldId: op2,
      MtoColumns.opt1.fieldId: opt1,
      MtoColumns.opt2.fieldId: opt2,
      MtoColumns.paintSpec.fieldId: paintSpec,
      MtoColumns.pipeStandard.fieldId: pipeStandard,
      MtoColumns.pos.fieldId: pos,
      MtoColumns.processLineList.fieldId: processLineList,
      MtoColumns.processUnit.fieldId: processUnit,
      MtoColumns.projectId.fieldId: projectId,
      MtoColumns.projectName.fieldId: projectName,
      MtoColumns.revision.fieldId: revision,
      MtoColumns.sequence.fieldId: sequence,
      MtoColumns.service.fieldId: service,
      MtoColumns.spoolNumber.fieldId: spoolNumber,
      MtoColumns.system.fieldId: system,
      MtoColumns.vendorDocumentId.fieldId: vendorDocumentId,
      MtoColumns.weldId.fieldId: weldId,
      MtoColumns.xray.fieldId: xray,
      MtoColumns.sysBuild.fieldId: sysBuild,
      MtoColumns.sysFilename.fieldId: sysFilename,
      MtoColumns.sysPath.fieldId: sysPath,
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

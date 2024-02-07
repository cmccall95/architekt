import 'package:equatable/equatable.dart';

import 'mto.dart';

class AISTableData extends Equatable {
  const AISTableData({
    required this.id,
    required this.data,
  });

  final int id;
  final Mto data;

  String? get drawing => data.drawing;
  String? get sheet => data.sheet;
  String? get ofSheet => data.ofSheet;
  String? get lineNumber => data.lineNumber;
  String? get pipeSpec => data.pipeSpec;
  String? get insulationSpec => data.insulationSpec;
  String? get pwht => data.pwht;
  String? get pAndId => data.pAndId;
  String? get area => data.area;
  String? get unit => data.unit;
  String? get item => data.item;
  String? get tag => data.tag;
  String? get quantity => data.quantity;
  String? get npsOd => data.npsOd;
  String? get npsId => data.npsId;
  String? get materialDescription => data.materialDescription;
  String? get heatTrace => data.heatTrace;
  String? get insulationThickness => data.insulationThickness;
  String? get clientDocumentId => data.clientDocumentId;
  String? get coordinate => data.coordinate;
  String? get cutPieceNo => data.cutPieceNo;
  String? get designCode => data.designCode;
  String? get dp1 => data.dp1;
  String? get dp2 => data.dp2;
  String? get dt1 => data.dt1;
  String? get dt2 => data.dt2;
  String? get document => data.document;
  String? get documentDescription => data.documentDescription;
  String? get documentId => data.documentId;
  String? get documentTitle => data.documentTitle;
  String? get elevation => data.elevation;
  String? get ident => data.ident;
  String? get length => data.length;
  String? get mediumCode => data.mediumCode;
  String? get op1 => data.op1;
  String? get op2 => data.op2;
  String? get opt1 => data.opt1;
  String? get opt2 => data.opt2;
  String? get paintSpec => data.paintSpec;
  String? get pipeStandard => data.pipeStandard;
  String? get pos => data.pos;
  String? get processLineList => data.processLineList;
  String? get processUnit => data.processUnit;
  String? get projectId => data.projectId;
  String? get projectName => data.projectName;
  String? get revision => data.revision;
  String? get sequence => data.sequence;
  String? get service => data.service;
  String? get spoolNumber => data.spoolNumber;
  String? get system => data.system;
  String? get vendorDocumentId => data.vendorDocumentId;
  String? get weldId => data.weldId;
  String? get xray => data.xray;
  String? get sysBuild => data.sysBuild;
  String? get sysFilename => data.sysFilename;
  String? get sysPath => data.sysPath;

  static AISTableData fromJson(Map<String, dynamic> json) {
    return AISTableData(
      id: json['id'],
      data: Mto.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      ...data.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, data];

  @override
  bool get stringify => true;
}

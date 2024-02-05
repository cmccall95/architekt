import 'package:equatable/equatable.dart';

import 'mto_columns.dart';

class PayloadOptions extends Equatable {
  const PayloadOptions({
    required this.aggregateColsGeneral,
    required this.keepColsGeneral,
    required this.mergeToBom,
    required this.bomMergeOn,
  });

  final List<MtoColumns> aggregateColsGeneral;
  final List<MtoColumns> keepColsGeneral;
  final List<MtoColumns> mergeToBom;
  final List<MtoColumns> bomMergeOn;

  static PayloadOptions fromJson(Map<String, dynamic> json) {
    List<MtoColumns> aggregateColsGeneral = [];
    final aggregateColsGeneralJson = json['aggregate_cols_general'];
    if (aggregateColsGeneralJson is List<String>) {
      aggregateColsGeneral = aggregateColsGeneralJson.map((e) {
        return MtoColumns.fromString(e);
      }).toList();
    }

    List<MtoColumns> keepColsGeneral = [];
    final keepColsGeneralJson = json['keep_cols_general'];
    if (keepColsGeneralJson is List<String>) {
      keepColsGeneral = keepColsGeneralJson.map((e) {
        return MtoColumns.fromString(e);
      }).toList();
    }

    List<MtoColumns> mergeToBom = [];
    final mergeToBomJson = json['merge_to_bom'];
    if (mergeToBomJson is List<String>) {
      mergeToBom = mergeToBomJson.map((e) {
        return MtoColumns.fromString(e);
      }).toList();
    }

    List<MtoColumns> bomMergeOn = [];
    final bomMergeOnJson = json['bom_merge_on'];
    if (bomMergeOnJson is List<String>) {
      bomMergeOn = bomMergeOnJson.map((e) {
        return MtoColumns.fromString(e);
      }).toList();
    }

    return PayloadOptions(
      aggregateColsGeneral: aggregateColsGeneral,
      keepColsGeneral: keepColsGeneral,
      mergeToBom: mergeToBom,
      bomMergeOn: bomMergeOn,
    );
  }

  Map<String, dynamic> toJson() {
    final aggregateColsGeneral = this.aggregateColsGeneral.map((e) {
      return e.toString();
    }).toList();

    final keepColsGeneral = this.keepColsGeneral.map((e) {
      return e.toString();
    }).toList();

    final mergeToBom = this.mergeToBom.map((e) {
      return e.toString();
    }).toList();

    final bomMergeOn = this.bomMergeOn.map((e) {
      return e.toString();
    }).toList();

    return {
      PayloadOptionsFieldId.aggregateColsGeneral.value: aggregateColsGeneral,
      PayloadOptionsFieldId.keepColsGeneral.value: keepColsGeneral,
      PayloadOptionsFieldId.mergeToBom.value: mergeToBom,
      PayloadOptionsFieldId.bomMergeOn.value: bomMergeOn,
    };
  }

  @override
  List<Object> get props => [
        aggregateColsGeneral,
        keepColsGeneral,
        mergeToBom,
        bomMergeOn,
      ];

  @override
  bool get stringify => true;
}

enum PayloadOptionsFieldId {
  aggregateColsGeneral('aggregate_cols_general'),
  keepColsGeneral('keep_cols_general'),
  mergeToBom('merge_to_bom'),
  bomMergeOn('bom_merge_on');

  const PayloadOptionsFieldId(this.value);
  final String value;
}

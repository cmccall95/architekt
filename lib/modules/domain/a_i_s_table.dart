import 'package:arkitekt/modules/domain/a_i_s_data.dart';

class AISTable {
  AISTable({
    required this.name,
    required this.data,
  });

  factory AISTable.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List;
    return AISTable(
      name: json['name'],
      data: data.map((e) => AISData.fromJson(e)).toList(),
    );
  }

  final String name;
  final List<AISData> data;
}

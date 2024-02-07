import 'package:arkitekt/modules/domain/mto.dart';

class AISTable {
  AISTable({
    required this.name,
    required this.data,
  });

  factory AISTable.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List;
    return AISTable(
      name: json['name'],
      data: data.map((e) => Mto.fromJson(e)).toList(),
    );
  }

  final String name;
  final List<Mto> data;
}

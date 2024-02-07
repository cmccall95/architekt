class DwgFile {
  DwgFile({
    required this.id,
    required this.name,
    required this.path,
  });

  final int id;
  final String name;
  final String path;

  static DwgFile fromJson(Map<String, dynamic> json) {
    return DwgFile(
      id: json[DwgFileFieldId.id.fieldId],
      name: json[DwgFileFieldId.name.fieldId],
      path: json[DwgFileFieldId.path.fieldId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DwgFileFieldId.id.fieldId: id,
      DwgFileFieldId.name.fieldId: name,
      DwgFileFieldId.path.fieldId: path,
    };
  }
}

enum DwgFileFieldId {
  id('id'),
  name('name'),
  path('path'),
  ;

  const DwgFileFieldId(this.fieldId);
  final String fieldId;
}

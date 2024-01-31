extension StringExtension on String {
  int? get toInt => int.tryParse(this);

  String get upperFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get toSentenceCase {
    if (isEmpty) return this;
    return split(RegExp(r'[_\s,]+')).map((word) => word.upperFirst).join(' ');
  }
}

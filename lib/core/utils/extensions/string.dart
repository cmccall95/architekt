extension StringExtension on String {
  int? get toInt => int.tryParse(this);
}

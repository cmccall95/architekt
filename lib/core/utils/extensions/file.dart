import 'dart:io';

extension FileX on File {
  String get _separator => Platform.pathSeparator;

  String get name => path.split(_separator).last;
  String get extension => path.split('.').last;
  String get nameWithoutExtension => name.split('.').first;
}

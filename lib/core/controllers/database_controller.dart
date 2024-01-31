import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_controller.g.dart';

@riverpod
class DatabaseController extends _$DatabaseController {
  @override
  Future<Database> build() async {
    final dbPath = join(await getDatabasesPath(), 'architekt.db');

    await ((await openDatabase(dbPath)).close());
    await deleteDatabase(dbPath);

    await Future.delayed(const Duration(seconds: 2));
    return openDatabase(dbPath, version: 1);
  }
}

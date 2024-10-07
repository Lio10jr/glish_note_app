import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class SqliteDatabase {
  static late Database _db;

  void initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'glishnote.db');

    final file = File(path);

    if (!await file.exists()) {
      // Si no existe, se crea un nuevo archivo
      await file.create(recursive: true);
    }
    _db = sqlite3.open(path);

    _db.execute('''
      CREATE TABLE IF NOT EXISTS verbs (
        key TEXT NOT NULL PRIMARY KEY,
        type TEXT NOT NULL,
        simple_form TEXT NOT NULL,
        third_person TEXT NOT NULL,
        simple_past TEXT NOT NULL,
        past_participle TEXT NOT NULL,
        gerund TEXT NOT NULL,
        meaning TEXT NOT NULL
      );

      CREATE TABLE IF NOT EXISTS vocabulary (
        key TEXT NOT NULL PRIMARY KEY,
        user TEXT NOT NULL,
        ingles TEXT NOT NULL,
        espanish TEXT NOT NULL,
        pronunciacion TEXT NOT NULL
      );
    ''');
  }

  static Database get db => _db;

  static void closeDatabase() {
    _db.dispose();
  }
}

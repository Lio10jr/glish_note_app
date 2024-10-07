import 'package:glish_note_app/data/sqlite3/sqlite.dart';
import 'package:glish_note_app/shared/models/vocabulary_note.dart';
import 'package:sqlite3/sqlite3.dart';

class VocabularyDataService {
  final Database db = SqliteDatabase.db;

  void insertVerb(VocabularyNote vocabulary) {
    db.execute('''
    INSERT INTO vocabulary (key, user, ingles, espanish, pronunciacion)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  ''', [
      vocabulary.key,
      vocabulary.user,
      vocabulary.ingles,
      vocabulary.espanish,
      vocabulary.pronunciacion
    ]);
  }

  List<VocabularyNote> getVerbs() {
    final List<VocabularyNote> vocabularyList = [];
    final ResultSet result = db.select('SELECT * from vocabulary');
    for (final row in result) {
      vocabularyList.add(VocabularyNote(
        key: row['key'] as String,
        user: row['user'] as String,
        ingles: row['ingles'] as String,
        espanish: row['espanish'] as String,
        pronunciacion: row['pronunciacion'] as String
      ));
    }

    return vocabularyList;
  }
}

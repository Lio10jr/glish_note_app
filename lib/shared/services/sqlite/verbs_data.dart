import 'package:glish_note_app/data/sqlite3/sqlite.dart';
import 'package:glish_note_app/shared/models/verbs_data_model.dart';
import 'package:sqlite3/sqlite3.dart';

class VerbsDataService {
  final Database db = SqliteDatabase.db;

  void insertVerb(VerbsDateModel verb) {
    db.execute('''
    INSERT INTO verbs (key, type, simple_form, third_person, simple_past, past_participle, gerund, meaning)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  ''', [
      verb.key,
      verb.type,
      verb.simple_form,
      verb.third_person,
      verb.simple_past,
      verb.past_participle,
      verb.gerund,
      verb.meaning
    ]);
  }

  List<VerbsDateModel> getVerbs() {
    final List<VerbsDateModel> verbsList = [];
    final ResultSet result = db.select('SELECT * from verbs');
    for (final row in result) {
      verbsList.add(VerbsDateModel(
        key: row['key'] as String,
        type: row['type'] as String,
        simple_form: row['simple_form'] as String,
        third_person: row['third_person'] as String,
        simple_past: row['simple_past'] as String,
        past_participle: row['past_participle'] as String,
        gerund: row['gerund'] as String,
        meaning: row['meaning'] as String,
      ));
    }

    return verbsList;
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:glish_note_app/shared/models/verbs_data_model.dart';

class VerbsServices {
  Future<bool> saveVerb(VerbsDateModel verb) async {
    try {
      String path = "Verbs";

      await FirebaseDatabase.instance.ref().child(path).push().set({
        "type": verb.type,
        "simple_form": verb.simple_form,
        "third_person": verb.third_person,
        "simple_past": verb.simple_past,
        "past_participle": verb.past_participle,
        "gerund": verb.gerund,
        "meaning": verb.meaning
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveVerbList(List<VerbsDateModel> verbList) async {
    try {
      String path = "Verbs";

      for (var verb in verbList) {
        await FirebaseDatabase.instance.ref().child(path).push().set({
          "type": verb.type,
          "simple_form": verb.simple_form,
          "third_person": verb.third_person,
          "simple_past": verb.simple_past,
          "past_participle": verb.past_participle,
          "gerund": verb.gerund,
          "meaning": verb.meaning
        });
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<VerbsDateModel>> getVerbs() async {
    List<VerbsDateModel> listt = [];
    String name = "Verbs";
    try {
      DataSnapshot sna =
          await FirebaseDatabase.instance.ref().child(name).get();

      for (DataSnapshot verb in sna.children) {
        VerbsDateModel verbObj = VerbsDateModel(
          key: verb.key.toString(),
          type: verb.child('type').value.toString(),
          simple_form: verb.child('simple_form').value.toString(),
          third_person: verb.child('third_person').value.toString(),
          simple_past: verb.child('simple_past').value.toString(),
          past_participle: verb.child('past_participle').value.toString(),
          gerund: verb.child('gerund').value.toString(),
          meaning: verb.child('meaning').value.toString()
        );

        listt.add(verbObj);
      }

      return listt;
    } catch (e) {
      return [];
    }
  }
}

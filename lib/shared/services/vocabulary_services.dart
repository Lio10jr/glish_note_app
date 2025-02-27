import 'package:firebase_database/firebase_database.dart';
import 'package:glish_note_app/shared/models/vocabulary_note.dart';

// ignore: camel_case_types
class VocabularyServices {

  Future<List<VocabularyNote>> getVocabulario(String email) async {
    List<VocabularyNote> list = [];
    try {
      final ref = FirebaseDatabase.instance.ref('VocabularyNote');
      ref.keepSynced(false);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        for (DataSnapshot sn in snapshot.children) {
          if (email == sn.child('email').value.toString()) {
            VocabularyNote ovn = VocabularyNote(
                key: sn.key.toString(),
                user: sn.child('email').value.toString(),
                espanish: sn.child('spanish').value.toString(),
                ingles: sn.child('ingles').value.toString(),
                pronunciacion: sn.child('pronunciacion').value.toString());
            list.add(ovn);
          }
        }
      }
      return list;
    } catch (e) {
      return list;
    }
  }

  Future<bool> saveVocabulario(
      String user, String ingles, String spanish, String pronunciacion) async {
    try {
      await FirebaseDatabase.instance.ref().child("VocabularyNote").push().set({
        'email': user,
        'ingles': ingles,
        'spanish': spanish,
        'pronunciacion': pronunciacion
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> eliminarVocabulario(String key) async {
    try {
      await FirebaseDatabase.instance
          .ref()
          .child('VocabularyNote')
          .child(key)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editarVocabulario(String key, String user, String ingles,
      String spanish, String pronunciacion) async {
    try {
      String name = "VocabularyNote";
      Map<String, String> value = {
        'ingles': ingles,
        'spanish': spanish,
        'pronunciacion': pronunciacion
      };
      await FirebaseDatabase.instance
          .ref()
          .child(name)
          .child(key)
          .update(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}

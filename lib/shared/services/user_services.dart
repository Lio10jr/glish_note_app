import 'package:firebase_database/firebase_database.dart';
import 'package:glish_note_app/shared/models/note_topic.dart';

class UserServices {

  Future<bool> saveApuntesTopic(
      String email, String tema, String contenido) async {
    try {
      String name = "Apuntes_Usuario";

      await FirebaseDatabase.instance.ref().child(name).push().set({
        'Email': email,
        'Tema': tema,
        'Contenido': contenido,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<NoteTopic>> getApuntesTopic(String email) async {
    List<NoteTopic> listt = [];
    String name = "Apuntes_Usuario";
    try {
      DataSnapshot sna =
          await FirebaseDatabase.instance.ref().child(name).get();

      for (DataSnapshot sn in sna.children) {
        if (email == sn.child('Email').value.toString()) {
          NoteTopic ovn = NoteTopic(
              key: sn.key.toString(),
              email: sn.child('Email').value.toString(),
              tema: sn.child('Tema').value.toString(),
              contenido: sn.child('Contenido').value.toString());
          listt.add(ovn);
        }
      }

      return listt;
    } catch (e) {
      return listt;
    }
  }

  Future<bool> editarNotas(String key, String tema, String contenido) async {
    try {
      String name = "Apuntes_Usuario";
      Map<String, String> value = {'Tema': tema, 'Contenido': contenido};
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

  Future<bool> eliminarApuntes(String key, String email, String tema) async {
    try {
      String name = "Apuntes_Usuario";
      await FirebaseDatabase.instance.ref().child(name).child(key).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

}
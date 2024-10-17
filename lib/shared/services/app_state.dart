import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/models/image_camera.dart';
import 'package:glish_note_app/shared/models/note_topic.dart';
import 'package:glish_note_app/shared/models/vocabulary_note.dart';
import 'package:glish_note_app/shared/services/apuntes_service.dart';
import 'package:glish_note_app/shared/services/vocabulary_services.dart';

class AppState with ChangeNotifier {
  List<VocabularyNote> _vocabularioList = [];
  List<NoteTopic> _apuntes = [];
  List<ImageCamera> imgsCamera = [];

  Future<bool> saveVocabulario(
      String s, String text, String text2, String text3) async {
    try {
      bool respuesta =
          await VocabularyServices().saveVocabulario(s, text, text2, text3);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<List<VocabularyNote>> obtenerVocabulario(String user) async {
    try {
      _vocabularioList = await VocabularyServices().getVocabulario(user);
      return _vocabularioList;
    } catch (e) {
      return _vocabularioList;
    }
  }

  Future<void> deleteVocabulario(String key) async {
    try {
      bool respuesta = await VocabularyServices().eliminarVocabulario(key);
      if (respuesta) {
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> editVocabulario(String key, String user, String ingles,
      String spanish, String pronunciacion) async {
    try {
      bool respuesta = await VocabularyServices()
          .editarVocabulario(key, user, ingles, spanish, pronunciacion);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editNota(String key, String tema, String contenido) async {
    try {
      bool respuesta = await ApuntesService().editarNotas(key, tema, contenido);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveApuntes(String s, String text, String text2) async {
    try {
      bool respuesta = await ApuntesService().saveApuntesTopic(s, text, text2);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteApuntes(String s, String text, String text2) async {
    try {
      bool respuesta = await ApuntesService().eliminarApuntes(s, text, text2);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<List<NoteTopic>> obtenerApuntes(String user) async {
    try {
      _apuntes = await ApuntesService().getApuntesTopic(user);
      return _apuntes;
    } catch (e) {
      return _apuntes;
    }
  }

}

import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/models/content_rating.dart';
import 'package:glish_note_app/shared/models/image_camera.dart';
import 'package:glish_note_app/shared/models/note_topic.dart';
import 'package:glish_note_app/shared/models/vocabulary_note.dart';
import 'package:glish_note_app/shared/services/rating_services.dart';
import 'package:glish_note_app/shared/services/user_services.dart';
import 'package:glish_note_app/shared/services/vocabulary_services.dart';

class AppState with ChangeNotifier {
  List<VocabularyNote> _vocabularioList = [];
  List<ContentRating> _calificacionList = [];
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
      bool respuesta = await UserServices().editarNotas(key, tema, contenido);
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
      bool respuesta = await UserServices().saveApuntesTopic(s, text, text2);
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
      bool respuesta = await UserServices().eliminarApuntes(s, text, text2);
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
      _apuntes = await UserServices().getApuntesTopic(user);
      return _apuntes;
    } catch (e) {
      return _apuntes;
    }
  }

  Future<bool> saveCalificacionContenido(
      String text, String text2, double valor, String text3) async {
    try {
      bool respuesta = await RatingServices()
          .saveValoracionContenido(text, text2, valor, text3);
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  Future<List<ContentRating>> obtenerValoracionContenido(String user) async {
    try {
      _calificacionList = await RatingServices().getValoracionContenido(user);
      return _calificacionList;
    } catch (e) {
      return _calificacionList;
    }
  }
}

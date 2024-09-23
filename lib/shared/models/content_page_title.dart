

import 'package:glish_note_app/shared/models/content.dart';

class ContentTitle {
  String titulo;
  String utilizacion;
  List<Content> contenido;

  ContentTitle({
    required this.titulo,
    required this.utilizacion,
    required this.contenido,
  }); 

  factory ContentTitle.fromJson(Map<String, dynamic> json) {
    List<dynamic> contenidoData = json['contenido'];

    List<Content> contenido = contenidoData.map((item) {
      return Content.fromJson(item);
    }).toList();

    return ContentTitle(
      titulo: json['titulo'] ?? '',
      utilizacion: json['Utilización'] ?? '',
      contenido: contenido,
    );
  }
}

import 'package:glish_note_app/shared/models/data_content.dart';

class Content {
  final String subtitulo;
  final List<DataContent> datos;

  Content({
    required this.subtitulo,
    required this.datos,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    final List<dynamic> datosData = json['datos'];
    final List<DataContent> datos = datosData.map((item) {
      return DataContent.fromJson(item);
    }).toList();

    return Content(
      subtitulo: json['subtitulo'],
      datos: datos,
    );
  }
}
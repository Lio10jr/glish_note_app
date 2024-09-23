class ContentPage{
  String? titulo;
  List<String>? subtitulos;

  ContentPage({required this.titulo, required this.subtitulos});

  ContentPage.fromJson(Map<String, dynamic> json){
    titulo = json['titulo'];
    subtitulos = List<String>.from(json['subtitulos']);
  }
}
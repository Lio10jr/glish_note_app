class DataContent {
  final String uso;
  final String informacion;
  final List<String> ejemplos;

  DataContent({
    required this.uso,
    required this.informacion,
    required this.ejemplos,
  });

  factory DataContent.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ejemplosData = json['Ejemplos'];
    final List<String> ejemplos = ejemplosData.map((item) {
      return item as String;
    }).toList();

    return DataContent(
      uso: json['uso'],
      informacion: json['informacion'],
      ejemplos: ejemplos,
    );
  }
}
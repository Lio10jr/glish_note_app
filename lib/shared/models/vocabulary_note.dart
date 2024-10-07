class VocabularyNote {
  VocabularyNote({
    required this.key,
    required this.user,
    required this.ingles,
    required this.espanish,
    required this.pronunciacion,
  });

  String key;
  String user;
  String ingles;
  String espanish;
  String pronunciacion;


  Map<String, Object?> toJson() => {
        key: key,
        user: user,
        ingles: ingles,
        espanish: espanish,
        pronunciacion: pronunciacion
      };
}
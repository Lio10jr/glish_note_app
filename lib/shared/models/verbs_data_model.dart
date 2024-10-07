// ignore_for_file: non_constant_identifier_names

class VerbsDateModel {
  VerbsDateModel({
    required this.key,
    required this.type,
    required this.simple_form,
    required this.third_person,
    required this.simple_past,
    required this.past_participle,
    required this.gerund,
    required this.meaning,
  });

  String key;
  String type;
  String simple_form;
  String third_person;
  String simple_past;
  String past_participle;
  String gerund;
  String meaning;

  Map<String, Object?> toJson() => {
        key: key,
        type: type,
        simple_form: simple_form,
        third_person: third_person,
        simple_past: simple_past,
        past_participle: past_participle,
        gerund: gerund,
        meaning: meaning,
      };
}

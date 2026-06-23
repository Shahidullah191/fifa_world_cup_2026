class TeamModel {
  final String id;
  final String nameEn;
  final String nameFa;
  final String flag;
  final String fifaCode;
  final String iso2;
  final String group;

  TeamModel({
    required this.id,
    required this.nameEn,
    required this.nameFa,
    required this.flag,
    required this.fifaCode,
    required this.iso2,
    required this.group,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      nameFa: json['name_fa']?.toString() ?? '',
      flag: json['flag']?.toString() ?? '',
      fifaCode: json['fifa_code']?.toString() ?? '',
      iso2: json['iso2']?.toString() ?? '',
      group: json['groups']?.toString() ?? '',
    );
  }
}

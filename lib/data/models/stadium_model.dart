class StadiumModel {
  final String id;
  final String nameEn;
  final String fifaName;
  final String cityEn;
  final String countryEn;
  final int capacity;
  final String region;

  StadiumModel({
    required this.id,
    required this.nameEn,
    required this.fifaName,
    required this.cityEn,
    required this.countryEn,
    required this.capacity,
    required this.region,
  });

  factory StadiumModel.fromJson(Map<String, dynamic> json) {
    return StadiumModel(
      id: json['id']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
      fifaName: json['fifa_name']?.toString() ?? '',
      cityEn: json['city_en']?.toString() ?? '',
      countryEn: json['country_en']?.toString() ?? '',
      capacity: int.tryParse(json['capacity']?.toString() ?? '0') ?? 0,
      region: json['region']?.toString() ?? '',
    );
  }

  String get countryFlag {
    switch (countryEn.toLowerCase()) {
      case 'united states':
        return '🇺🇸';
      case 'mexico':
        return '🇲🇽';
      case 'canada':
        return '🇨🇦';
      default:
        return '🏟️';
    }
  }
}

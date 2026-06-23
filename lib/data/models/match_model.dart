enum MatchStatus { live, finished, upcoming }

class MatchModel {
  final String id;
  final String homeTeamId;
  final String awayTeamId;
  final String homeTeamName;
  final String awayTeamName;
  final int? homeScore;
  final int? awayScore;
  final String group;
  final String matchday;
  final String localDate;
  final String stadiumId;
  final bool isFinished;
  final String timeElapsed;
  final String type;
  final String? homeScorers;
  final String? awayScorers;

  MatchModel({
    required this.id,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.homeTeamName,
    required this.awayTeamName,
    this.homeScore,
    this.awayScore,
    required this.group,
    required this.matchday,
    required this.localDate,
    required this.stadiumId,
    required this.isFinished,
    required this.timeElapsed,
    required this.type,
    this.homeScorers,
    this.awayScorers,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    final finished = (json['finished']?.toString().toUpperCase() ?? '') == 'TRUE';
    final timeElapsed = json['time_elapsed']?.toString() ?? '';

    return MatchModel(
      id: json['id']?.toString() ?? '',
      homeTeamId: json['home_team_id']?.toString() ?? '',
      awayTeamId: json['away_team_id']?.toString() ?? '',
      homeTeamName: json['home_team_name_en']?.toString() ?? '',
      awayTeamName: json['away_team_name_en']?.toString() ?? '',
      homeScore: int.tryParse(json['home_score']?.toString() ?? ''),
      awayScore: int.tryParse(json['away_score']?.toString() ?? ''),
      group: json['group']?.toString() ?? '',
      matchday: json['matchday']?.toString() ?? '',
      localDate: json['local_date']?.toString() ?? '',
      stadiumId: json['stadium_id']?.toString() ?? '',
      isFinished: finished,
      timeElapsed: timeElapsed,
      type: json['type']?.toString() ?? 'group',
      homeScorers: json['home_scorers']?.toString(),
      awayScorers: json['away_scorers']?.toString(),
    );
  }

  MatchStatus get status {
    final elapsed = timeElapsed.toLowerCase().trim();

    if (isFinished || elapsed == 'finished') {
      return MatchStatus.finished;
    }

    if (elapsed == 'notstarted' ||
        elapsed.isEmpty ||
        elapsed == '0' ||
        elapsed == 'null') {
      return MatchStatus.upcoming;
    }

    return MatchStatus.live;
  }

  bool get isLive => status == MatchStatus.live;

  String get stageLabel {
    switch (type.toLowerCase()) {
      case 'group':
        return 'Group $group';
      case 'round16':
        return 'Round of 16';
      case 'quarter':
        return 'Quarter Final';
      case 'semi':
        return 'Semi Final';
      case 'third':
        return '3rd Place';
      case 'final':
        return 'Final';
      default:
        return type;
    }
  }

  DateTime? get parsedDate {
    try {
      final parts = localDate.split(' ');
      if (parts.length < 2) return null;
      final dateParts = parts[0].split('/');
      final timeParts = parts[1].split(':');
      if (dateParts.length != 3 || timeParts.length < 2) return null;
      return DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (_) {
      return null;
    }
  }
}

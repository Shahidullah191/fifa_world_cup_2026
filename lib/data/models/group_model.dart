import 'team_model.dart';

class GroupStandingModel {
  final String teamId;
  final int played;
  final int won;
  final int lost;
  final int drawn;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDiff;

  GroupStandingModel({
    required this.teamId,
    required this.played,
    required this.won,
    required this.lost,
    required this.drawn,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDiff,
  });

  factory GroupStandingModel.fromJson(Map<String, dynamic> json) {
    return GroupStandingModel(
      teamId: json['team_id']?.toString() ?? '',
      played: int.tryParse(json['mp']?.toString() ?? '0') ?? 0,
      won: int.tryParse(json['w']?.toString() ?? '0') ?? 0,
      lost: int.tryParse(json['l']?.toString() ?? '0') ?? 0,
      drawn: int.tryParse(json['d']?.toString() ?? '0') ?? 0,
      points: int.tryParse(json['pts']?.toString() ?? '0') ?? 0,
      goalsFor: int.tryParse(json['gf']?.toString() ?? '0') ?? 0,
      goalsAgainst: int.tryParse(json['ga']?.toString() ?? '0') ?? 0,
      goalDiff: int.tryParse(json['gd']?.toString() ?? '0') ?? 0,
    );
  }
}

class GroupModel {
  final String name;
  final List<GroupStandingModel> standings;

  GroupModel({required this.name, required this.standings});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final teams = (json['teams'] as List<dynamic>? ?? [])
        .map((e) => GroupStandingModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return GroupModel(
      name: json['name']?.toString() ?? '',
      standings: teams,
    );
  }

  List<GroupStandingModel> sortedStandings() {
    final sorted = List<GroupStandingModel>.from(standings);
    sorted.sort((a, b) {
      if (b.points != a.points) return b.points.compareTo(a.points);
      if (b.goalDiff != a.goalDiff) return b.goalDiff.compareTo(a.goalDiff);
      return b.goalsFor.compareTo(a.goalsFor);
    });
    return sorted;
  }
}

class GroupWithTeams {
  final GroupModel group;
  final Map<String, TeamModel> teamMap;

  GroupWithTeams({required this.group, required this.teamMap});

  TeamModel? teamFor(String teamId) => teamMap[teamId];
}

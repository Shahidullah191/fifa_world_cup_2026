import 'package:get/get.dart';

import '../../core/network/api_client.dart';
import '../models/group_model.dart';
import '../models/match_model.dart';
import '../models/stadium_model.dart';
import '../models/team_model.dart';
import '../services/world_cup_api_service.dart';

class WorldCupRepository extends GetxService {
  late final WorldCupApiService _api;

  final RxList<MatchModel> matches = <MatchModel>[].obs;
  final RxList<TeamModel> teams = <TeamModel>[].obs;
  final RxList<GroupModel> groups = <GroupModel>[].obs;
  final RxList<StadiumModel> stadiums = <StadiumModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<DateTime?> lastUpdated = Rx<DateTime?>(null);

  Map<String, TeamModel> _teamMap = {};

  @override
  void onInit() {
    super.onInit();
    _api = WorldCupApiService(ApiClient());
  }

  TeamModel? teamById(String id) => _teamMap[id];

  StadiumModel? stadiumById(String id) {
    try {
      return stadiums.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  List<MatchModel> get liveMatches =>
      matches.where((m) => m.isLive).toList();

  List<MatchModel> get upcomingMatches {
    final upcoming = matches.where((m) => m.status == MatchStatus.upcoming).toList();
    upcoming.sort((a, b) {
      final da = a.parsedDate;
      final db = b.parsedDate;
      if (da == null || db == null) return 0;
      return da.compareTo(db);
    });
    return upcoming;
  }

  List<MatchModel> get finishedMatches {
    final finished =
        matches.where((m) => m.status == MatchStatus.finished).toList();
    finished.sort((a, b) {
      final da = a.parsedDate;
      final db = b.parsedDate;
      if (da == null || db == null) return 0;
      return db.compareTo(da);
    });
    return finished;
  }

  List<GroupWithTeams> get groupsWithTeams {
    return groups.map((g) {
      return GroupWithTeams(group: g, teamMap: _teamMap);
    }).toList()
      ..sort((a, b) => a.group.name.compareTo(b.group.name));
  }

  List<MatchModel> matchesForTeam(String teamId) {
    return matches
        .where((m) => m.homeTeamId == teamId || m.awayTeamId == teamId)
        .toList();
  }

  Future<void> loadAll({bool silent = false}) async {
    if (!silent) {
      isLoading.value = true;
      error.value = '';
    }
    try {
      final results = await Future.wait([
        _api.fetchMatches(),
        _api.fetchTeams(),
        _api.fetchGroups(),
        _api.fetchStadiums(),
      ]);

      matches.assignAll(results[0] as List<MatchModel>);
      teams.assignAll(results[1] as List<TeamModel>);
      groups.assignAll(results[2] as List<GroupModel>);
      stadiums.assignAll(results[3] as List<StadiumModel>);

      _teamMap = {for (final t in teams) t.id: t};
      lastUpdated.value = DateTime.now();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';

import '../../data/models/match_model.dart';
import '../../data/models/team_model.dart';
import '../../data/repositories/world_cup_repository.dart';

class TeamDetailController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();

  late final String teamId;

  @override
  void onInit() {
    super.onInit();
    teamId = Get.parameters['id'] ?? '';
  }

  TeamModel? get team {
    try {
      return repo.teams.firstWhere((t) => t.id == teamId);
    } catch (_) {
      return null;
    }
  }

  List<MatchModel> get teamMatches => repo.matchesForTeam(teamId);
}

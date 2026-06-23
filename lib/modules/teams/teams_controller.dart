import 'package:get/get.dart';

import '../../data/models/team_model.dart';
import '../../data/repositories/world_cup_repository.dart';

class TeamsController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();
  final searchQuery = ''.obs;

  List<TeamModel> get filteredTeams {
    final sorted = List<TeamModel>.from(repo.teams)
      ..sort((a, b) => a.nameEn.compareTo(b.nameEn));

    if (searchQuery.value.isEmpty) return sorted;
    final q = searchQuery.value.toLowerCase();
    return sorted
        .where((t) =>
            t.nameEn.toLowerCase().contains(q) ||
            t.fifaCode.toLowerCase().contains(q) ||
            t.group.toLowerCase().contains(q))
        .toList();
  }

  void search(String query) => searchQuery.value = query;
  Future<void> reload() => repo.loadAll(silent: true);
}

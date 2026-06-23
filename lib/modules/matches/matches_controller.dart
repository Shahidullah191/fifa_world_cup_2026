import 'package:get/get.dart';

import '../../data/models/match_model.dart';
import '../../data/repositories/world_cup_repository.dart';

enum MatchFilter { all, live, upcoming, finished }

class MatchesController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();
  final filter = MatchFilter.all.obs;
  final selectedGroup = ''.obs;

  List<String> get groups {
    final groupSet = repo.matches.map((m) => m.group).toSet().toList();
    groupSet.sort();
    return groupSet;
  }

  List<MatchModel> get filteredMatches {
    List<MatchModel> result;
    switch (filter.value) {
      case MatchFilter.live:
        result = repo.liveMatches;
        break;
      case MatchFilter.upcoming:
        result = repo.upcomingMatches;
        break;
      case MatchFilter.finished:
        result = repo.finishedMatches;
        break;
      case MatchFilter.all:
        result = List.from(repo.matches);
        result.sort((a, b) {
          final da = a.parsedDate;
          final db = b.parsedDate;
          if (da == null || db == null) return 0;
          return da.compareTo(db);
        });
    }

    if (selectedGroup.value.isNotEmpty) {
      result = result.where((m) => m.group == selectedGroup.value).toList();
    }
    return result;
  }

  void setFilter(MatchFilter f) => filter.value = f;
  void setGroup(String group) => selectedGroup.value = group;
  void clearGroup() => selectedGroup.value = '';

  Future<void> reload() => repo.loadAll(silent: true);
}

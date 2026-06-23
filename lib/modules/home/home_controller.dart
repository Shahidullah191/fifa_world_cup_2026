import 'package:get/get.dart';

import '../../data/repositories/world_cup_repository.dart';

class HomeController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();

  List<dynamic> get liveMatches => repo.liveMatches;
  List<dynamic> get upcomingMatches => repo.upcomingMatches.take(5).toList();
  List<dynamic> get recentResults => repo.finishedMatches.take(5).toList();

  int get totalTeams => repo.teams.length;
  int get totalMatches => repo.matches.length;
  int get totalStadiums => repo.stadiums.length;
  int get liveCount => repo.liveMatches.length;

  Future<void> reload() => repo.loadAll(silent: true);
}

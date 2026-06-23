import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repositories/world_cup_repository.dart';
import '../../modules/groups/groups_controller.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/main/main_controller.dart';
import '../../modules/match_detail/match_detail_controller.dart';
import '../../modules/matches/matches_controller.dart';
import '../../modules/stadium_detail/stadium_detail_controller.dart';
import '../../modules/stadiums/stadiums_controller.dart';
import '../../modules/team_detail/team_detail_controller.dart';
import '../../modules/teams/teams_controller.dart';

/// Central dependency injection for the entire app.
class DependencyInjection {
  DependencyInjection._();

  /// Call once from [main] before [runApp].
  static Future<void> init() async {
    await GetStorage.init();
    _registerCore();
    await Get.find<WorldCupRepository>().loadAll();
  }

  static void _registerCore() {
    if (!Get.isRegistered<WorldCupRepository>()) {
      Get.put<WorldCupRepository>(WorldCupRepository(), permanent: true);
    }
  }

  static void main() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MatchesController>(() => MatchesController());
    Get.lazyPut<GroupsController>(() => GroupsController());
    Get.lazyPut<TeamsController>(() => TeamsController());
    Get.lazyPut<StadiumsController>(() => StadiumsController());
  }

  static void matchDetail() {
    Get.lazyPut<MatchDetailController>(() => MatchDetailController());
  }

  static void teamDetail() {
    Get.lazyPut<TeamDetailController>(() => TeamDetailController());
  }

  static void stadiumDetail() {
    Get.lazyPut<StadiumDetailController>(() => StadiumDetailController());
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() => DependencyInjection.main();
}

class MatchDetailBinding extends Bindings {
  @override
  void dependencies() => DependencyInjection.matchDetail();
}

class TeamDetailBinding extends Bindings {
  @override
  void dependencies() => DependencyInjection.teamDetail();
}

class StadiumDetailBinding extends Bindings {
  @override
  void dependencies() => DependencyInjection.stadiumDetail();
}

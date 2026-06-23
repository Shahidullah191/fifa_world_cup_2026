import 'package:get/get.dart';

import '../../data/repositories/world_cup_repository.dart';
import '../groups/groups_controller.dart';
import '../home/home_controller.dart';
import '../matches/matches_controller.dart';
import '../stadiums/stadiums_controller.dart';
import '../teams/teams_controller.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) => currentIndex.value = index;

  Future<void> refreshAll() async {
    final repo = Get.find<WorldCupRepository>();
    await repo.loadAll(silent: true);
    Get.find<HomeController>().update();
    Get.find<MatchesController>().update();
    Get.find<GroupsController>().update();
    Get.find<TeamsController>().update();
    Get.find<StadiumsController>().update();
  }
}

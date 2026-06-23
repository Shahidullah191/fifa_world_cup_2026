import 'package:get/get.dart';

import 'main_controller.dart';
import '../groups/groups_controller.dart';
import '../home/home_controller.dart';
import '../matches/matches_controller.dart';
import '../stadiums/stadiums_controller.dart';
import '../teams/teams_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MatchesController>(() => MatchesController());
    Get.lazyPut<GroupsController>(() => GroupsController());
    Get.lazyPut<TeamsController>(() => TeamsController());
    Get.lazyPut<StadiumsController>(() => StadiumsController());
  }
}

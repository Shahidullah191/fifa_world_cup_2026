import 'package:get/get.dart';

import 'team_detail_controller.dart';

class TeamDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamDetailController>(() => TeamDetailController());
  }
}

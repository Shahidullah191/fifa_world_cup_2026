import 'package:get/get.dart';

import '../../data/repositories/world_cup_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<WorldCupRepository>()) {
      Get.put(WorldCupRepository(), permanent: true);
    }
  }
}

import 'package:get/get.dart';

import '../../data/repositories/world_cup_repository.dart';

class GroupsController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();

  Future<void> reload() => repo.loadAll(silent: true);
}

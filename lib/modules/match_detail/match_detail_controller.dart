import 'package:get/get.dart';

import '../../data/models/match_model.dart';
import '../../data/repositories/world_cup_repository.dart';

class MatchDetailController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();

  late final String matchId;

  @override
  void onInit() {
    super.onInit();
    matchId = Get.parameters['id'] ?? '';
  }

  MatchModel? get match {
    try {
      return repo.matches.firstWhere((m) => m.id == matchId);
    } catch (_) {
      return null;
    }
  }
}

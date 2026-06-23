import 'package:get/get.dart';

import '../../modules/main/main_binding.dart';
import '../../modules/main/main_view.dart';
import '../../modules/match_detail/match_detail_binding.dart';
import '../../modules/match_detail/match_detail_view.dart';
import '../../modules/stadium_detail/stadium_detail_binding.dart';
import '../../modules/stadium_detail/stadium_detail_view.dart';
import '../../modules/team_detail/team_detail_binding.dart';
import '../../modules/team_detail/team_detail_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.main;

  static final routes = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.matchDetail,
      page: () => const MatchDetailView(),
      binding: MatchDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.teamDetail,
      page: () => const TeamDetailView(),
      binding: TeamDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.stadiumDetail,
      page: () => const StadiumDetailView(),
      binding: StadiumDetailBinding(),
    ),
  ];
}

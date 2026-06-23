import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/themes/app_colors.dart';
import '../../data/models/match_model.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/match_card.dart';
import '../../widgets/tournament_header.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.repo.isLoading.value && controller.repo.matches.isEmpty) {
        return const LoadingShimmer();
      }
      if (controller.repo.error.isNotEmpty && controller.repo.matches.isEmpty) {
        return ErrorView(
          message: controller.repo.error.value,
          onRetry: controller.reload,
        );
      }

      return RefreshIndicator(
        onRefresh: controller.reload,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: TournamentHeader()),
            SliverToBoxAdapter(child: _statsRow()),
            if (controller.liveCount > 0) ...[
              _sectionTitle('🔴 Live Now', controller.liveCount),
              _matchList(controller.liveMatches.cast<MatchModel>()),
            ],
            _sectionTitle('📅 Upcoming', controller.upcomingMatches.length),
            _matchList(controller.upcomingMatches.cast<MatchModel>()),
            _sectionTitle('✅ Recent Results', controller.recentResults.length),
            _matchList(controller.recentResults.cast<MatchModel>()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      );
    });
  }

  Widget _statsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          _statCard('Teams', '${controller.totalTeams}', Icons.groups),
          const SizedBox(width: 10),
          _statCard('Matches', '${controller.totalMatches}', Icons.sports_soccer),
          const SizedBox(width: 10),
          _statCard('Venues', '${controller.totalStadiums}', Icons.stadium),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _matchList(List<MatchModel> matches) {
    if (matches.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'No matches to show',
            style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.7)),
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MatchCard(
            match: matches[index],
            repo: controller.repo,
            onTap: () => Get.toNamed(
              AppRoutes.matchDetail.replaceAll(':id', matches[index].id),
            ),
          ),
        ),
        childCount: matches.length,
      ),
    );
  }
}

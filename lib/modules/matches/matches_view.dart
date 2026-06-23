import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/themes/app_colors.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/match_card.dart';
import 'matches_controller.dart';

class MatchesView extends GetView<MatchesController> {
  const MatchesView({super.key});

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

      return Column(
        children: [
          _appBar(),
          _filterChips(),
          _groupChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.reload,
              color: AppColors.primary,
              child: controller.filteredMatches.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 80),
                        Center(
                          child: Text(
                            'No matches found',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.filteredMatches.length,
                      itemBuilder: (_, i) {
                        final match = controller.filteredMatches[i];
                        return MatchCard(
                          match: match,
                          repo: controller.repo,
                          onTap: () => Get.toNamed(
                            AppRoutes.matchDetail.replaceAll(':id', match.id),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      );
    });
  }

  Widget _appBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.sports_soccer, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Text(
            'All Matches',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: MatchFilter.values.map((f) {
          final isSelected = controller.filter.value == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_filterLabel(f)),
              selected: isSelected,
              onSelected: (_) => controller.setFilter(f),
              selectedColor: AppColors.primary.withValues(alpha: 0.3),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _groupChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          _groupChip('All', controller.selectedGroup.value.isEmpty),
          ...controller.groups.map(
            (g) => _groupChip('Group $g', controller.selectedGroup.value == g,
                group: g),
          ),
        ],
      ),
    );
  }

  Widget _groupChip(String label, bool isSelected, {String group = ''}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        onPressed: () {
          if (group.isEmpty) {
            controller.clearGroup();
          } else {
            controller.setGroup(group);
          }
        },
        backgroundColor:
            isSelected ? AppColors.accent.withValues(alpha: 0.2) : AppColors.surfaceLight,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.accent : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  String _filterLabel(MatchFilter f) {
    switch (f) {
      case MatchFilter.all:
        return 'All';
      case MatchFilter.live:
        return '🔴 Live';
      case MatchFilter.upcoming:
        return 'Upcoming';
      case MatchFilter.finished:
        return 'Finished';
    }
  }
}

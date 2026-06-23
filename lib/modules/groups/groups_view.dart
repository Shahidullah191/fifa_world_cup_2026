import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/themes/app_colors.dart';
import '../../widgets/error_view.dart';
import '../../widgets/group_table.dart';
import '../../widgets/loading_shimmer.dart';
import 'groups_controller.dart';

class GroupsView extends GetView<GroupsController> {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.repo.isLoading.value && controller.repo.groups.isEmpty) {
        return const LoadingShimmer(itemCount: 4, height: 220);
      }
      if (controller.repo.error.isNotEmpty && controller.repo.groups.isEmpty) {
        return ErrorView(
          message: controller.repo.error.value,
          onRetry: controller.reload,
        );
      }

      final groups = controller.repo.groupsWithTeams;

      return Column(
        children: [
          _appBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.reload,
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: groups.length,
                itemBuilder: (_, i) => GroupTable(
                  groupData: groups[i],
                  repo: controller.repo,
                ),
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
          Icon(Icons.leaderboard_rounded, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group Standings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                '12 Groups · Top 2 advance',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

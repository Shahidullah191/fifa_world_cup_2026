import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../app/routes/app_routes.dart';
import '../../app/themes/app_colors.dart';
import '../../widgets/match_card.dart';
import 'stadium_detail_controller.dart';

class StadiumDetailView extends GetView<StadiumDetailController> {
  const StadiumDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final stadium = controller.stadium;
    if (stadium == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Stadium')),
        body: const Center(child: Text('Stadium not found')),
      );
    }

    final matches = controller.stadiumMatches;
    final formatter = NumberFormat('#,###');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.headerGradient),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        stadium.countryFlag,
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          stadium.nameEn,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        '${stadium.cityEn}, ${stadium.countryEn}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _stat(Icons.people, 'Capacity', formatter.format(stadium.capacity)),
                  const SizedBox(width: 12),
                  _stat(Icons.map, 'Region', stadium.region),
                  const SizedBox(width: 12),
                  _stat(Icons.sports_soccer, 'Matches', '${matches.length}'),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'FIFA Name: ${stadium.fifaName}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Scheduled Matches',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final match = matches[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MatchCard(
                    match: match,
                    repo: controller.repo,
                    onTap: () => Get.toNamed(
                      AppRoutes.matchDetail.replaceAll(':id', match.id),
                    ),
                  ),
                );
              },
              childCount: matches.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String label, String value) {
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
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

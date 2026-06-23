import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../app/routes/app_routes.dart';
import '../../app/themes/app_colors.dart';
import '../../data/models/stadium_model.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_shimmer.dart';
import 'stadiums_controller.dart';

class StadiumsView extends GetView<StadiumsController> {
  const StadiumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.repo.isLoading.value && controller.repo.stadiums.isEmpty) {
        return const LoadingShimmer(itemCount: 6, height: 120);
      }
      if (controller.repo.error.isNotEmpty &&
          controller.repo.stadiums.isEmpty) {
        return ErrorView(
          message: controller.repo.error.value,
          onRetry: controller.reload,
        );
      }

      return Column(
        children: [
          _appBar(),
          _countryChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.reload,
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredStadiums.length,
                itemBuilder: (_, i) {
                  final stadium = controller.filteredStadiums[i];
                  return _stadiumCard(stadium);
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
          Icon(Icons.stadium_rounded, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Host Venues',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                '16 Stadiums across 3 nations',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _countryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          _chip('All', controller.selectedCountry.value.isEmpty),
          ...controller.countries.map(
            (c) => _chip(c, controller.selectedCountry.value == c, country: c),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, {String country = ''}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          if (country.isEmpty) {
            controller.clearCountry();
          } else {
            controller.setCountry(country);
          }
        },
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        checkmarkColor: AppColors.primary,
      ),
    );
  }

  Widget _stadiumCard(StadiumModel stadium) {
    final formatter = NumberFormat.compact();
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.stadiumDetail.replaceAll(':id', stadium.id),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                stadium.countryFlag,
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stadium.nameEn,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stadium.cityEn}, ${stadium.countryEn}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _badge(Icons.people, formatter.format(stadium.capacity)),
                      const SizedBox(width: 8),
                      _badge(Icons.map, stadium.region),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _badge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

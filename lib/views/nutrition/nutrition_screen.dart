import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_typography.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../widgets/calendar_strip.dart';
import '../widgets/workout_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/hydration_card.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    // Listen to changes
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          AppAssets.bellIcon,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.weekIndicator,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Week 1/4',
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(width: 24), // Balance for bell
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Calendar date
                    Text(
                      'Today, ${_viewModel.selectedDate.day} Dec ${_viewModel.selectedDate.year}',
                      style: AppTypography.subHeader,
                    ),
                    const SizedBox(height: 16),

                    // Calendar Strip
                    CalendarStrip(
                      days: _viewModel.days,
                      onDateSelected: (date) => _viewModel.selectDate(date),
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Workouts Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Workouts', style: AppTypography.subHeader),
                        Row(
                          children: [
                            const Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '9°',
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const WorkoutCard(),

                    const SizedBox(height: 24),

                    // My Insights
                    Text('My Insights', style: AppTypography.subHeader),
                    const SizedBox(height: 16),

                    // Grid
                    Row(
                      children: [
                        Expanded(
                          child: InsightCard(
                            title: '',
                            value: '${_viewModel.caloriesData.consumed}',
                            subtitle: 'Cal',
                            customContent: CaloriesProgress(
                              remaining: _viewModel.caloriesData.remaining,
                            ),
                            footerLeft: '0',
                            footerRight: '${_viewModel.caloriesData.goal}',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InsightCard(
                            title: 'Weight',
                            value: '${_viewModel.weightData.current}',
                            subtitle: 'kg',
                            customContent: WeightBadge(
                              change: _viewModel.weightData.change,
                              isGain: _viewModel.weightData.isGain,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Hydration
                    Stack(
                      children: [
                        HydrationCard(data: _viewModel.hydrationData),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFF163E48),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '500 ml added to water log',
                                style: AppTypography.caption.copyWith(
                                  color: const Color(0xFFA7C0C6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

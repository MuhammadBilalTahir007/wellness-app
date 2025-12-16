import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../viewmodels/training_viewmodel.dart';
import 'widgets/week_summary_section.dart';
import 'widgets/next_week_preview_section.dart';
import 'widgets/day_slot.dart';

class TrainingCalendarScreen extends StatefulWidget {
  const TrainingCalendarScreen({super.key});

  @override
  State<TrainingCalendarScreen> createState() => _TrainingCalendarScreenState();
}

class _TrainingCalendarScreenState extends State<TrainingCalendarScreen> {
  final TrainingViewModel _viewModel = TrainingViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Training Calendar', style: AppTypography.header),
                  Text(
                    'Save',
                    style: AppTypography.body.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Week Summary
            WeekSummarySection(viewModel: _viewModel),

            // Timeline List
            Expanded(
              child: ListenableBuilder(
                listenable: _viewModel,
                builder: (context, child) {
                  return ListView.builder(
                    itemCount: _viewModel.days.length,
                    itemBuilder: (context, index) {
                      final day = _viewModel.days[index];
                      return DaySlot(
                        day: day,
                        viewModel: _viewModel,
                        isFirst: index == 0,
                      );
                    },
                  );
                },
              ),
            ),

            // Next Week Preview
            const NextWeekPreviewSection(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_typography.dart';
import '../../../models/training_models.dart';
import '../../../viewmodels/training_viewmodel.dart';
import '../../widgets/draggable_workout_tile.dart';

class DaySlot extends StatelessWidget {
  final TrainingDay day;
  final TrainingViewModel viewModel;
  final bool isFirst;

  const DaySlot({
    super.key,
    required this.day,
    required this.viewModel,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    bool hasWorkout = day.workouts.isNotEmpty;
    Color textColor = hasWorkout
        ? Colors.white
        : AppColors.navBarUnSelectedItem;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isFirst)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Divider(
              color: AppColors.navBarUnSelectedItem,
              height: 1.h,
              thickness: 1.h,
            ),
          ),
        DragTarget<TrainingWorkout>(
          onWillAcceptWithDetails: (details) => true,
          onAcceptWithDetails: (details) {
            viewModel.onWorkoutDropped(details.data, day.date);
          },
          builder: (context, candidateData, rejectedData) {
            bool isHovered = candidateData.isNotEmpty;

            return Container(
              color: isHovered
                  ? Colors.white.withOpacity(0.05)
                  : Colors.transparent, // Highlight on hover
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Column
                    SizedBox(
                      width: 40.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day.dayName,
                            style: AppTypography.caption.copyWith(
                              fontSize: 14.sp,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${day.date.day}',
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Expanded(
                      child: day.workouts.isEmpty
                          ? SizedBox(height: 10.h)
                          : Column(
                              children: day.workouts
                                  .map(
                                    (workout) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: DraggableWorkoutTile(
                                        workout: workout,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

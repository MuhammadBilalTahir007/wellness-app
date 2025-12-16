import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/training_models.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_colors.dart';

class DraggableWorkoutTile extends StatelessWidget {
  final TrainingWorkout workout;

  const DraggableWorkoutTile({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<TrainingWorkout>(
      data: workout,
      delay: const Duration(milliseconds: 200), // Snappier drag
      hapticFeedbackOnStart: true,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.9, // Higher opacity for visibility
          child: _buildTileContent(context, isFeedback: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildTileContent(context),
      ),
      child: _buildTileContent(context),
    );
  }

  Widget _buildTileContent(BuildContext context, {bool isFeedback = false}) {
    // Colors
    // Arms: #20B76F
    // Legs: #4855DF
    Color baseColor;
    String iconAsset;

    if (workout.type == WorkoutType.arms) {
      baseColor = const Color(0xFF20B76F);
      iconAsset = AppAssets.trainingArms;
    } else {
      // Legs
      baseColor = const Color(0xFF4855DF);
      iconAsset = AppAssets.trainingLegs;
    }

    return Container(
      width:
          MediaQuery.of(context).size.width -
          40.w -
          40.w -
          12.w -
          5.w, // Dynamic responsive width
      constraints: BoxConstraints(minHeight: 60.h),
      decoration: BoxDecoration(
        color: const Color(0xFF18181C), // Dark BG
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left Strip
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB), // Light Strip
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    // Handle Icon
                    Icon(
                      Icons.drag_indicator,
                      color: Colors.grey[600],
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Tag Container
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: baseColor.withOpacity(0.17), // Tag BG
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  iconAsset,
                                  width: 14.w,
                                  height: 14.h,
                                  colorFilter: ColorFilter.mode(
                                    baseColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  workout.type == WorkoutType.arms
                                      ? 'Arms Workout'
                                      : 'Leg Workout',
                                  style: AppTypography.caption.copyWith(
                                    color: baseColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // Title & Duration Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                workout.title,
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                workout.duration,
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

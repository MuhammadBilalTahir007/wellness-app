import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';

import '../../models/home_models.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutData? data;

  const WorkoutCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final workout =
        data ??
        WorkoutData(
          title: 'Upper Body',
          subtitle: 'December 22 - 25m - 30m',
          isRestDay: false,
        ); // Default/Fallback

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        color: AppColors.cardBackground,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The teal vertical bar (Full Height)
              Container(width: 10.w, color: AppColors.primaryAccent),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout.subtitle,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              workout.title,
                              style: AppTypography.header.copyWith(
                                color: Colors.white,
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

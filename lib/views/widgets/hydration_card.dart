import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../models/home_models.dart';

class HydrationCard extends StatelessWidget {
  final HydrationData data;
  const HydrationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${((data.current / data.goal) * 100).toInt()}%',
                  style: AppTypography.numberBig.copyWith(
                    color: AppColors.hydrationColor,
                    fontSize: 40.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Hydration',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  'Log Now',
                  style: AppTypography.caption.copyWith(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          // Vertical Scale
          SizedBox(
            height: 130.h, // Fixed height for the scale
            width: 150.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: (data.current / data.goal).clamp(0.0, 1.0) * 126.h,
                  right: 0,
                  left: 0,
                  child: Row(
                    children: [
                      SizedBox(width: 48.w),

                      Expanded(
                        child: Container(height: 1.h, color: Colors.grey),
                      ),

                      SizedBox(width: 4.w),

                      // The Text
                      Text(
                        '${data.current}ml',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Static Scale Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 2L Top Marker
                    _markerRow('2 L', true),
                    for (int i = 0; i < 4; i++) _dashRow(),
                    _markerRow('', true),
                    for (int i = 0; i < 4; i++) _dashRow(),
                    _markerRow('0 L', true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _markerRow(String label, bool isMajor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        SizedBox(
          width: 30.w,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: AppTypography.caption.copyWith(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          ),
        ),
        SizedBox(width: 8.w),

        // Marker Line
        Container(width: 12.w, height: 2.h, color: const Color(0xFF48A4E5)),

        SizedBox(width: 40.w),
      ],
    );
  }

  Widget _dashRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 38.w),
          Container(
            width: 4.w,
            height: 2.h,
            color: const Color(0xFF48A4E5).withOpacity(0.3),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}

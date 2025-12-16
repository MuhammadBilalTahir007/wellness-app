import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/viewmodels/home_viewmodel.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../utils/app_assets.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? footerLeft;
  final String? footerRight;
  final Widget? customContent;

  const InsightCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.footerLeft,
    this.footerRight,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.h,
      padding: EdgeInsets.only(top: 16.h, right: 12.w, left: 12.w, bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.numberBig.copyWith(fontSize: 36.sp),
              ),
              if (subtitle != null) ...[
                SizedBox(width: 2.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(
                    subtitle!,
                    style: AppTypography.body.copyWith(fontSize: 15.sp),
                  ),
                ),
              ],
            ],
          ),

          if (customContent != null) ...[SizedBox(height: 1.h), customContent!],

          SizedBox(height: 12.h),
          if (footerLeft != null && footerRight != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(footerLeft!, style: AppTypography.caption),
                Text(footerRight!, style: AppTypography.caption),
              ],
            )
          else if (title.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                title,
                style: AppTypography.body.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class CaloriesProgress extends StatelessWidget {
  final int remaining;
  const CaloriesProgress({super.key, required this.remaining});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel _viewModel = HomeViewModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$remaining Remaining', style: AppTypography.captionMedium),
        SizedBox(height: 18.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "0",
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              "${_viewModel.caloriesData.goal}",
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Container(
          height: 4.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 50.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7BBDE2),
                    Color(0xFF69C0B1),
                    Color(0xFF60C198),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeightBadge extends StatelessWidget {
  final double change;
  final bool isGain;

  const WeightBadge({super.key, required this.change, required this.isGain});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Aligned left
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26.w,
            height: 26.h,
            decoration: const BoxDecoration(
              color: Colors.transparent, // Replaced with SVG
            ),
            child: SvgPicture.asset(AppAssets.upwardsTrajectory),
          ),
          SizedBox(width: 4.w),
          Text('+$change kg', style: AppTypography.captionMedium),
        ],
      ),
    );
  }
}

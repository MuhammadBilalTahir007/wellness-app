import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/views/widgets/top_glow.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../viewmodels/mood_viewmodel.dart';
import '../widgets/mood_circular_slider.dart';
import '../widgets/app_button.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final MoodViewModel _viewModel = MoodViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -250.h,
            left: 0,
            right: 0,
            height: 620.h,
            child: const TopGlow(),
          ),
          // Main content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: ListenableBuilder(
                          listenable: _viewModel,
                          builder: (context, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mood',
                                  style: AppTypography.header.copyWith(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 32.h),

                                Text(
                                  'Start your day',
                                  style: AppTypography.caption.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'How are you feeling at the\nMoment?',
                                  style: AppTypography.subHeader.copyWith(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const Spacer(),

                                // Circular Slider
                                Center(
                                  child: SizedBox(
                                    width: 300.w,
                                    height: 300.w,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        MoodCircularSlider(
                                          moodStates: _viewModel.moodStates,
                                          currentAngle: _viewModel.currentAngle,
                                          onAngleChanged:
                                              _viewModel.updateAngle,
                                        ),

                                        // Center mood icon
                                        SvgPicture.asset(
                                          _viewModel.currentMood.svgAsset,
                                          width: 100.w,
                                          height: 100.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 32.h),
                                Center(
                                  child: Text(
                                    _viewModel.currentMood.label,
                                    style: AppTypography.subHeader,
                                  ),
                                ),

                                const Spacer(),

                                // Continue Button
                                SizedBox(
                                  height: 45.h,
                                  child: AppButton(
                                    label: 'Continue',
                                    onPressed: () {
                                      // Handle continue action
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

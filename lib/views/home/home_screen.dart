import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../utils/date_utils.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_typography.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../widgets/calendar_strip.dart';
import '../widgets/workout_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/hydration_card.dart';
import '../widgets/month_calendar_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          AppAssets.bellIcon,
                          width: 24.w,
                          height: 24.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            debugPrint("TOUCH DETECTED");

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => MonthCalendarSheet(
                                initialDate: _viewModel.selectedDate,
                                onDateSelected: (date) =>
                                    _viewModel.selectDate(date),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.weekIndicator,
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _viewModel.weekStr,
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
                        ),
                        SizedBox(width: 24.w), // Balance for bell
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Calendar date
                    Text(
                      AppDateUtils.isSameDay(
                            _viewModel.selectedDate,
                            DateTime.now(),
                          )
                          ? 'Today, ${DateFormat('d MMM').format(_viewModel.selectedDate)}'
                          : DateFormat(
                              'EEEE, d MMM',
                            ).format(_viewModel.selectedDate),
                      style: AppTypography.subHeader,
                    ),
                    SizedBox(height: 16.h),

                    // Calendar Strip
                    CalendarStrip(
                      days: _viewModel.days,
                      onDateSelected: (date) => _viewModel.selectDate(date),
                    ),

                    SizedBox(height: 10.h),
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Workouts Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Workouts', style: AppTypography.header),
                        Row(
                          children: [
                            SvgPicture.asset(
                              (DateTime.now().hour > 6 &&
                                      DateTime.now().hour < 18)
                                  ? AppAssets.sunIcon
                                  : AppAssets.moonIcon,
                              width: 20.w,
                              height: 20.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '9°',
                              style: AppTypography.numberBig.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    WorkoutCard(data: _viewModel.currentWorkout),

                    SizedBox(height: 24.h),

                    // My Insights
                    Text('My Insights', style: AppTypography.header),
                    SizedBox(height: 16.h),

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
                            // footerLeft: '0',
                            // footerRight: '${_viewModel.caloriesData.goal}',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: InsightCard(
                            title: 'Weight',
                            value:
                                '${_viewModel.weightData.current.toStringAsFixed(0)}',
                            subtitle: 'kg',
                            customContent: WeightBadge(
                              change: _viewModel.weightData.change,
                              isGain: _viewModel.weightData.isGain,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Hydration
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        HydrationCard(data: _viewModel.hydrationData),
                        Positioned(
                          bottom: -40.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF163E48),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16.r),
                                bottomRight: Radius.circular(16.r),
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
                    SizedBox(height: 80.h),
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

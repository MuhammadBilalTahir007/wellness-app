import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import '../../models/home_models.dart';
import 'package:intl/intl.dart';

class CalendarStrip extends StatelessWidget {
  final List<DayModel> days;
  final Function(DateTime) onDateSelected;

  const CalendarStrip({
    super.key,
    required this.days,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: days.map((day) {
            return GestureDetector(
              onTap: () => onDateSelected(day.date),
              child: Column(
                children: [
                  Text(
                    DateFormat('E')
                        .format(day.date)
                        .toUpperCase()
                        .substring(0, 1), // M, T, W...
                    style: AppTypography.caption.copyWith(
                      color: day.isSelected ? Colors.white : Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: day.isSelected
                          ? Border.all(
                              color: AppColors.secondaryAccent,
                              width: 2.w,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: day.isSelected
                              ? Colors.transparent
                              : const Color(0xFF2C2C2E),
                        ),
                        child: Center(
                          child: Text(
                            '${day.date.day}',
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  day.isToday // Green dot for Today
                      ? Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryAccent,
                            shape: BoxShape.circle,
                          ),
                        )
                      : SizedBox(height: 4.h),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

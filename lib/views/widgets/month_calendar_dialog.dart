import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_typography.dart';
import 'package:intl/intl.dart';

class MonthCalendarSheet extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const MonthCalendarSheet({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<MonthCalendarSheet> createState() => _MonthCalendarSheetState();
}

class _MonthCalendarSheetState extends State<MonthCalendarSheet> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  void _changeMonth(int offset) {
    setState(() {
      _focusedMonth = DateTime(
        _focusedMonth.year,
        _focusedMonth.month + offset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // No longer a Dialog, just the content for BottomSheet
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () => _changeMonth(-1),
              ),
              Text(
                DateFormat('MMM yyyy').format(_focusedMonth),
                style: AppTypography.header,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Weekday Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: AppTypography.caption.copyWith(
                          color: const Color(0xFFEBEBF5).withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 12.h),

          // Days Grid
          _buildDaysGrid(),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildDaysGrid() {
    final days = _getDaysInMonthGrid(_focusedMonth);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final date = days[index];
        final isCurrentMonth = date.month == _focusedMonth.month;
        final isSelected =
            date.year == _selectedDate.year &&
            date.month == _selectedDate.month &&
            date.day == _selectedDate.day;

        return GestureDetector(
          onTap: () {
            widget.onDateSelected(date);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.secondaryAccent.withAlpha(75)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: AppColors.secondaryAccent.withAlpha(255),
                      width: 3.w,
                    )
                  : (isSameDay(date, DateTime.now())
                        ? Border.all(
                            color: AppColors.secondaryAccent.withAlpha(255),
                            width: 1.w, // Added width explicitly for consistency
                          )
                        : null),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: AppTypography.bodySmall.copyWith(
                  color: isSelected
                      ? Colors.white
                      : (isCurrentMonth ? Colors.white : Colors.grey[700]),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<DateTime> _getDaysInMonthGrid(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    int daysToSubtract = firstDay.weekday - 1;
    final startGrid = firstDay.subtract(Duration(days: daysToSubtract));
    return List.generate(42, (index) => startGrid.add(Duration(days: index)));
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

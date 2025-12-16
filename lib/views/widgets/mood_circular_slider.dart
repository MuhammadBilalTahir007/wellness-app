import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testapp/utils/app_colors.dart';
import 'dart:math' as math;
import '../../models/mood_models.dart';

class MoodCircularSlider extends StatelessWidget {
  final List<MoodState> moodStates;
  final double currentAngle;
  final Function(double) onAngleChanged;

  const MoodCircularSlider({
    super.key,
    required this.moodStates,
    required this.currentAngle,
    required this.onAngleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _handlePan(context, details.globalPosition),
      onPanStart: (details) => _handlePan(context, details.globalPosition),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(300.w, 300.w),
            painter: MoodRingPainter(moodStates: moodStates),
          ),

          // The draggable knob
          _buildKnob(),
        ],
      ),
    );
  }

  Widget _buildKnob() {
    double radius = 120.w;
    final dx = 150.w + radius * math.cos(currentAngle);
    final dy = 150.w + radius * math.sin(currentAngle);

    return Positioned(
      left: dx - 30.w,
      top: dy - 30.w,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.w),
          color: AppColors.knobInnerColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.r,
              spreadRadius: 2.r,
            ),
          ],
        ),
      ),
    );
  }

  void _handlePan(BuildContext context, Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(globalPosition);

    // Calculate center of the widget
    final center = Offset(box.size.width / 2, box.size.height / 2);

    // Calculate angle from center
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    final angle = math.atan2(dy, dx);
    onAngleChanged(angle);
  }
}

class MoodRingPainter extends CustomPainter {
  final List<MoodState> moodStates;

  MoodRingPainter({required this.moodStates});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double radius = 120.w;
    double strokeWidth = 30.w;
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (moodStates.isEmpty) return;

    final cContent = moodStates
        .firstWhere((m) => m.type == MoodType.content)
        .color;
    final cPeaceful = moodStates
        .firstWhere((m) => m.type == MoodType.peaceful)
        .color;
    final cHappy = moodStates.firstWhere((m) => m.type == MoodType.happy).color;
    final cCalm = moodStates.firstWhere((m) => m.type == MoodType.calm).color;

    final colors = [
      Color.lerp(cContent, cCalm, 0.5)!, // 0°
      cContent, // 45°
      Color.lerp(cContent, cPeaceful, 0.5)!, // 90°
      cPeaceful, // 135°
      Color.lerp(cPeaceful, cHappy, 0.5)!, // 180°
      cHappy, // 225°
      Color.lerp(cHappy, cCalm, 0.5)!, // 270°
      cCalm, // 315°
      Color.lerp(cContent, cCalm, 0.5)!, // 360°
    ];

    final stops = [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0];

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * math.pi,
      colors: colors,
      stops: stops,
      tileMode: TileMode.repeated,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..shader = gradient.createShader(rect);

    canvas.drawArc(rect, 0, 2 * math.pi, false, paint);

    // Draw evenly spaced division lines
    const numberOfLines = 16;
    for (int i = 0; i < numberOfLines; i++) {
      final angle = (i * 2 * math.pi) / numberOfLines;
      _drawDivisionLine(canvas, center, radius, angle, strokeWidth);
    }
  }

  void _drawDivisionLine(
    Canvas canvas,
    Offset center,
    double radius,
    double angle,
    double strokeWidth,
  ) {
    final innerRadius = radius - strokeWidth / 2;
    final outerRadius = radius + strokeWidth / 2;

    final innerPoint = Offset(
      center.dx + innerRadius * math.cos(angle),
      center.dy + innerRadius * math.sin(angle),
    );

    final outerPoint = Offset(
      center.dx + outerRadius * math.cos(angle),
      center.dy + outerRadius * math.sin(angle),
    );

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 1.5.w
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(innerPoint, outerPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

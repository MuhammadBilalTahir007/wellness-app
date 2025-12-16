import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopGlow extends StatefulWidget {
  const TopGlow({super.key});

  @override
  State<TopGlow> createState() => _TopGlowState();
}

class _TopGlowState extends State<TopGlow> {
  ui.Image? _noise;

  @override
  void initState() {
    super.initState();
    _makeNoise().then((img) {
      if (mounted) setState(() => _noise = img);
    });
  }

  Future<ui.Image> _makeNoise({int size = 128, int seed = 7}) async {
    final rand = Random(seed);
    final bytes = Uint8List(size * size * 4);

    for (int i = 0; i < size * size; i++) {
      final v = 128 + rand.nextInt(33) - 16;
      final o = i * 4;
      bytes[o + 0] = v; // R
      bytes[o + 1] = v; // G
      bytes[o + 2] = v; // B
      bytes[o + 3] = 255; // A
    }

    final c = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      bytes,
      size,
      size,
      ui.PixelFormat.rgba8888,
      (img) => c.complete(img),
    );
    return c.future;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _TopGlowPainter()),
          if (_noise != null) CustomPaint(painter: _NoisePainter(_noise!)),
        ],
      ),
    );
  }
}

class _TopGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Blur the whole glow layer once (prevents ring artifacts).
    canvas.saveLayer(
      rect,
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 60.r, sigmaY: 60.r),
    );

    // Center inside the paint box (DON’T use negative y here).
    final center = Offset(size.width / 2, 190.h);

    _glow(canvas, center, 340.r, const Color(0xFF47FFF6).withOpacity(0.24));
    _glow(
      canvas,
      center.translate(0, 18.h),
      320.r,
      const Color(0xFF47B2FF).withOpacity(0.22),
    );
    _glow(
      canvas,
      center.translate(0, 8.h),
      270.r,
      const Color(0xFFC547FF).withOpacity(0.22),
    );

    canvas.restore();
  }

  void _glow(Canvas canvas, Offset c, double r, Color color) {
    final paint = Paint()
      ..shader = ui.Gradient.radial(
        c,
        r,
        [
          color,
          color.withOpacity(color.opacity * 0.70),
          color.withOpacity(color.opacity * 0.80),
          color.withOpacity(color.opacity * 0.15),
          Colors.transparent,
        ],
        const [0.0, 0.25, 0.50, 0.70, 1.0],
        TileMode.clamp,
      );

    canvas.drawCircle(c, r, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NoisePainter extends CustomPainter {
  final ui.Image noise;
  _NoisePainter(this.noise);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final shader = ImageShader(
      noise,
      TileMode.repeated,
      TileMode.repeated,
      // scale the noise a bit (smaller = finer grain)
      Matrix4.identity().scaled(0.6, 0.6).storage,
    );

    final paint = Paint()
      ..shader = shader
      ..blendMode = BlendMode.softLight
      ..color = Colors.white.withOpacity(0.95); // intensity of dithering

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      ),
      body: Center(
        child: Text(
          '$title Screen',
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 20),
        ),
      ),
    );
  }
}

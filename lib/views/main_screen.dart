import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/app_assets.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.navBarUnSelectedItem,
        showUnselectedLabels: true,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        iconSize: 24.w,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navNutrition,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.navBarUnSelectedItem,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.navNutrition,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navPlan,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.navBarUnSelectedItem,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.navPlan,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navMood,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.navBarUnSelectedItem,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.navMood,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navProfile,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.navBarUnSelectedItem,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.navProfile,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

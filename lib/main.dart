import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/app_colors.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const WellnessApp());
}

class WellnessApp extends StatelessWidget {
  const WellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Wellness App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryAccent,
              secondary: AppColors.secondaryAccent,
              surface: AppColors.cardBackground,
              background: AppColors
                  .background, // Deprecated in some versions but fine here
            ),
            useMaterial3: true,
            fontFamily: GoogleFonts.mulish().fontFamily,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/motion_preference.dart';
import 'core/utils/responsive_helper.dart';
import 'presentation/pages/narrow_portfolio_page.dart';
import 'routes/app_router.dart';

void main() {
  VisibilityDetectorController.instance.updateInterval = const Duration(
    milliseconds: 90,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => ValueListenableBuilder<bool>(
          valueListenable: browserReducedMotion,
          builder: (context, reduced, _) {
            final disableAnimations =
                reduced ||
                (MediaQuery.maybeOf(context)?.disableAnimations ?? false);
            return MaterialApp.router(
              title: 'Ahmed Elghareeb | Flutter & Mobile Developer',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              themeAnimationDuration: disableAnimations
                  ? Duration.zero
                  : PortfolioLayout.fast,
              routerConfig: AppRouter.router,
              builder: (context, child) {
                // Apply the width limit above the navigator so an open drawer or
                // case study also yields to the fallback on a live resize.
                final page =
                    MediaQuery.sizeOf(context).width <
                        PortfolioLayout.minCompactWidth
                    ? const NarrowPortfolioPage()
                    : child!;
                if (!disableAnimations) return page;
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(disableAnimations: true),
                  child: page,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

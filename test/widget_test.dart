import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/presentation/widgets/common/portfolio_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );

  const widths = [
    320.0,
    360.0,
    375.0,
    390.0,
    430.0,
    600.0,
    768.0,
    1024.0,
    1280.0,
    1440.0,
    1920.0,
    2560.0,
  ];
  for (final width in widths) {
    testWidgets('All sections fit at ${width.toInt()} px', (tester) async {
      _viewport(tester, Size(width, 850));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      if (width >= 1440) {
        for (final frame in find.byType(ContentWidth).evaluate()) {
          final cap = find
              .descendant(
                of: find.byWidget(frame.widget),
                matching: find.byType(ConstrainedBox),
              )
              .first;
          expect(tester.getSize(cap).width, 1280);
          expect(tester.getTopLeft(cap).dx, (width - 1280) / 2);
        }
        expect(
          find.byType(BackdropFilter),
          findsNWidgets(width < 2560 ? 2 : 0),
        );
      }

      for (final title in [
        'Featured work',
        'All projects',
        'Experience',
        'Technical expertise',
        'About',
        'Get in touch',
      ]) {
        final heading = find.text(title).last;
        await tester.ensureVisible(heading);
        await tester.pumpAndSettle();
        expect(heading.hitTestable(), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });
  }

  for (final size in [
    const Size(320, 430),
    const Size(690, 280),
    const Size(1440, 540),
  ]) {
    testWidgets('Short or landscape viewport $size supports enlarged text', (
      tester,
    ) async {
      _viewport(tester, size);
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: size,
              textScaler: const TextScaler.linear(2),
              disableAnimations: true,
            ),
            child: const MyApp(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(PortfolioData.name), findsOneWidget);
      expect(
        MediaQuery.textScalerOf(
          tester.element(find.text(PortfolioData.name)),
        ).scale(16),
        32,
      );
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Email Ahmed'));
      await tester.pumpAndSettle();
      expect(find.text('Email Ahmed').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Mobile drawer navigates to Projects and supports dismissal', (
    tester,
  ) async {
    _viewport(tester, const Size(320, 560));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation'));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await tester.tap(find.widgetWithText(ListTile, 'Projects'));
    await tester.pumpAndSettle();
    expect(find.text('All projects').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tab and Enter reach and activate the desktop Work link', (
    tester,
  ) async {
    _viewport(tester, const Size(1440, 900));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    expect(Focus.of(tester.element(find.text('Work'))).hasFocus, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Featured work').hitTestable(), findsOneWidget);
  });

  testWidgets('Theme toggles light and back to dark', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Switch to light theme'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text(PortfolioData.name))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byTooltip('Switch to dark theme'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text(PortfolioData.name))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('Desktop blur pauses while scrolling and returns once settled', (
    tester,
  ) async {
    _viewport(tester, const Size(1440, 900));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final frost = find.byType(BackdropFilter);
    expect(
      tester.widgetList<BackdropFilter>(frost).map((filter) => filter.enabled),
      [true, true],
    );

    await tester.tap(find.text('Work'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(
      tester.widgetList<BackdropFilter>(frost).map((filter) => filter.enabled),
      [false, false],
    );

    await tester.pumpAndSettle();
    expect(
      tester.widgetList<BackdropFilter>(frost).map((filter) => filter.enabled),
      [true, true],
    );
  });

  testWidgets(
    'Reduced motion anchor navigation completes without an animated scroll',
    (tester) async {
      _viewport(tester, const Size(390, 740));
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      final explore = find.text('Explore My Work');
      await tester.dragUntilVisible(
        explore,
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(explore);
      await tester.pump();
      expect(find.text('Featured work').hitTestable(), findsOneWidget);
    },
  );

  testWidgets('Reduced motion opens the compact menu without a slide', (
    tester,
  ) async {
    _viewport(tester, const Size(320, 430));
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.byTooltip('Open navigation'));
    await tester.pump();
    final drawer = tester.element(find.byType(Drawer));
    expect(ModalRoute.of(drawer)?.transitionDuration, Duration.zero);
    expect(find.widgetWithText(ListTile, 'Work').hitTestable(), findsOneWidget);

    await tester.tap(find.byTooltip('Close navigation'));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsNothing);
  });
}

void _viewport(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}

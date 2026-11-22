import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/presentation/widgets/common/glass_card.dart';
import 'package:my_portfolio/presentation/widgets/sections/projects_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );
  const viewports = [
    (320.0, 1),
    (375.0, 1),
    (430.0, 1),
    (600.0, 1),
    (768.0, 2),
    (1024.0, 2),
    (1440.0, 3),
  ];

  for (final (width, columns) in viewports) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('Projects fit at ${width.toInt()} px and ${scale}x text', (
        tester,
      ) async {
        await _pumpProjects(tester, width: width, scale: scale);
        final firstRowTop = tester
            .getTopLeft(find.text(PortfolioData.projects.first.title))
            .dy;
        final topTitles = PortfolioData.projects.where(
          (project) =>
              (tester.getTopLeft(find.text(project.title)).dy - firstRowTop)
                  .abs() <
              1,
        );
        expect(topTitles, hasLength(columns));

        for (final project in PortfolioData.projects) {
          final description = find.text(project.description);
          final paragraph = tester.renderObject<RenderParagraph>(
            find.descendant(of: description, matching: find.byType(RichText)),
          );
          expect(paragraph.didExceedMaxLines, isFalse);
          expect(
            paragraph.size.height,
            greaterThanOrEqualTo(paragraph.textSize.height),
          );
          expect(tester.getTopLeft(description).dx, greaterThanOrEqualTo(0));
          expect(tester.getTopRight(description).dx, lessThanOrEqualTo(width));
        }
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets(
    'Ride-Hailing filter retains both app variants and their store actions',
    (tester) async {
      await _pumpProjects(tester, width: 320);
      final chip = find.widgetWithText(ChoiceChip, 'Ride-Hailing');
      await tester.ensureVisible(chip);
      await tester.tap(chip);
      await tester.pumpAndSettle();

      expect(find.text('1 project'), findsOneWidget);
      expect(find.text('UFOO'), findsOneWidget);
      expect(find.text('Zidcash'), findsNothing);
      expect(find.text('Customer · Google Play'), findsOneWidget);
      expect(find.text('Driver · App Store'), findsOneWidget);

      final details = find.text('Project details');
      await tester.ensureVisible(details);
      await tester.tap(details);
      await tester.pumpAndSettle();
      expect(find.text('How it works'), findsOneWidget);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.text('How it works'), findsNothing);
    },
  );

  testWidgets('Featured image frames retain 16:9 proportions at narrow width', (
    tester,
  ) async {
    await _pumpProjects(tester, width: 320, featured: true, scale: 2);
    final frames = find.byType(AspectRatio);
    expect(frames, findsNWidgets(PortfolioData.featured.length));
    for (final element in frames.evaluate()) {
      expect(
        tester.getSize(find.byWidget(element.widget)).aspectRatio,
        closeTo(16 / 9, .001),
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Cards reflow within a constrained parent', (tester) async {
    await _pumpProjects(tester, width: 1440, parentWidth: 560);
    expect(
      tester.getTopLeft(find.text('Hussein Khaled')).dy,
      greaterThan(tester.getBottomLeft(find.text('Core Team – SmartHub')).dy),
    );
  });

  testWidgets(
    'Repeated filtering preserves cards that match the new category',
    (tester) async {
      await _pumpProjects(tester, width: 1024);
      final zidcash = tester.element(find.text('Zidcash'));
      for (final category in ['Fintech', 'All', 'Fintech', 'All']) {
        await tester.tap(find.widgetWithText(ChoiceChip, category));
        await tester.pumpAndSettle();
        expect(tester.element(find.text('Zidcash')), same(zidcash));
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets('Glass hover changes the surface without moving the card', (
    tester,
  ) async {
    await _pumpProjects(tester, width: 1440);
    final card = find.byType(GlassCard).first;
    final surface = find
        .descendant(of: card, matching: find.byType(DecoratedBox))
        .first;
    final initial =
        tester.widget<DecoratedBox>(surface).decoration as BoxDecoration;
    final bounds = tester.getRect(card);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: tester.getCenter(card));
    addTearDown(mouse.removePointer);
    await tester.pumpAndSettle();

    final hovered =
        tester.widget<DecoratedBox>(surface).decoration as BoxDecoration;
    expect(hovered.border, isNot(initial.border));
    expect(hovered.boxShadow, isNotEmpty);
    expect(tester.getRect(card), bounds);
  });
}

Future<void> _pumpProjects(
  WidgetTester tester, {
  required double width,
  double scale = 1,
  double? parentWidth,
  bool featured = false,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 850);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  await tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(scale),
          disableAnimations: true,
        ),
        child: child!,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: parentWidth,
              child: featured
                  ? const FeaturedProjectsSection()
                  : const ProjectsSection(),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

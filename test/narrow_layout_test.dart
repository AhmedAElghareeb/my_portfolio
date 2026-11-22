import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/presentation/pages/narrow_portfolio_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );

  for (final width in [118.0, 150.0, 200.0, 240.0]) {
    testWidgets('Narrow viewport $width renders a readable fallback', (
      tester,
    ) async {
      await _open(tester, width);

      expect(find.byType(NarrowPortfolioPage), findsOneWidget);
      expect(find.text('AE').hitTestable(), findsOneWidget);
      expect(find.byTooltip('Open navigation'), findsNothing);
      expect(find.text('Explore My Work'), findsNothing);
      _expectWholeWords(tester, 'Ahmed Elghareeb');
      _expectWholeWords(tester, 'Widen your window');
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [280.0, 300.0]) {
    testWidgets('Compact viewport $width keeps the portfolio and menu', (
      tester,
    ) async {
      await _open(tester, width);

      expect(find.byType(NarrowPortfolioPage), findsNothing);
      expect(find.text('AE').hitTestable(), findsOneWidget);
      _expectWholeWords(tester, 'Ahmed Elghareeb');

      await tester.tap(find.byTooltip('Open navigation'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Projects'));
      await tester.pumpAndSettle();

      expect(find.text('All projects').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    '320 px keeps the full hero name in whole words with enlarged text',
    (tester) async {
      await _open(tester, 320, textScaler: const TextScaler.linear(2));

      expect(find.byType(NarrowPortfolioPage), findsNothing);
      expect(find.byTooltip('Open navigation').hitTestable(), findsOneWidget);
      expect(
        find.byTooltip('Switch to light theme').hitTestable(),
        findsOneWidget,
      );
      _expectWholeWords(tester, PortfolioData.name);
      _expectWholeWords(tester, 'Technical expertise');

      final cta = find.text('Explore My Work');
      await tester.ensureVisible(cta);
      await tester.tap(cta);
      await tester.pumpAndSettle();
      expect(find.text('Featured work').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('The small fallback supports enlarged text and theme switching', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _open(tester, 150, textScaler: const TextScaler.linear(2));

      _expectWholeWords(tester, 'Ahmed Elghareeb');
      _expectWholeWords(tester, 'Widen your window');
      await tester.tap(find.bySemanticsLabel('Switch to light theme').first);
      await tester.pumpAndSettle();

      final heading = tester.element(find.text('Widen your window'));
      expect(Theme.of(heading).brightness, Brightness.light);
      expect(tester.takeException(), isNull);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets(
    'Resizing with the drawer open yields to the fallback and restores navigation',
    (tester) async {
      await _open(tester, 320);
      await tester.tap(find.byTooltip('Open navigation'));
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);

      tester.view.physicalSize = const Size(118, 600);
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsNothing);
      expect(find.byType(NarrowPortfolioPage), findsOneWidget);
      expect(tester.takeException(), isNull);

      tester.view.physicalSize = const Size(320, 600);
      await tester.pumpAndSettle();
      expect(find.text(PortfolioData.name), findsOneWidget);
      await tester.tap(find.byTooltip('Open navigation'));
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _open(
  WidgetTester tester,
  double width, {
  TextScaler? textScaler,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 600);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  final app = textScaler == null
      ? const MyApp()
      : Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: textScaler),
            child: const MyApp(),
          ),
        );
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void _expectWholeWords(WidgetTester tester, String text) {
  final paragraph = tester.renderObject<RenderParagraph>(
    find.descendant(of: find.text(text), matching: find.byType(RichText)).first,
  );
  for (final word in RegExp(r'\S+').allMatches(text)) {
    final boxes = paragraph.getBoxesForSelection(
      TextSelection(baseOffset: word.start, extentOffset: word.end),
    );
    expect(
      boxes.map((box) => box.top).toSet(),
      hasLength(1),
      reason: '${word.group(0)} should stay on one line',
    );
  }
  expect(paragraph.didExceedMaxLines, isFalse);
}

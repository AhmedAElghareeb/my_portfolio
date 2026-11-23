import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/presentation/widgets/common/portfolio_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );

  testWidgets('A scroll reveal waits for visibility and leaves text readable', (
    tester,
  ) async {
    const target = Key('lower-section');
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 900),
                Reveal(key: target, child: Text('Section content')),
                SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
    final opacity = find.descendant(
      of: find.byKey(target),
      matching: find.byType(Opacity),
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(tester.widget<Opacity>(opacity).opacity, .58);
    await tester.ensureVisible(find.byKey(target));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(tester.widget<Opacity>(opacity).opacity, 1);
    expect(find.text('Section content').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reduced motion shows the final reveal state immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Scaffold(body: Reveal(child: Text('Accessible content'))),
        ),
      ),
    );
    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
    expect(find.byType(VisibilityDetector), findsNothing);
  });

  testWidgets('Hero navigation accepts a tap before lower sections mount', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MyApp());
    expect(find.text('Featured work'), findsNothing);
    await tester.tapAt(tester.getCenter(find.text('Explore My Work')));
    await tester.pumpAndSettle();
    expect(find.text('Featured work').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Below-fold sections append without moving the Hero', (
    tester,
  ) async {
    await tester.pumpWidget(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: const MyApp(),
        ),
      ),
    );
    final hero = find.text('Explore My Work');
    final initial = tester.getTopLeft(hero);
    expect(find.text('Featured work'), findsNothing);

    await tester.pump();
    expect(find.text('Featured work'), findsOneWidget);
    expect(find.text('All projects'), findsNothing);

    await tester.pumpAndSettle();
    expect(find.text('Get in touch'), findsOneWidget);
    expect(tester.getTopLeft(hero), initial);
    expect(tester.takeException(), isNull);
  });

  testWidgets('An early Contact tap mounts through the destination', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MyApp());
    expect(find.text('Get in touch'), findsNothing);

    await tester.tapAt(tester.getCenter(find.text('Get In Touch')));
    await tester.pumpAndSettle();

    expect(find.text('Get in touch').hitTestable(), findsOneWidget);
    expect(find.text('All projects'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('Versioned browser and manifest icons have the advertised formats', () {
    final html = File('web/index.html').readAsStringSync();
    final manifest =
        jsonDecode(File('web/manifest.json').readAsStringSync())
            as Map<String, dynamic>;
    expect(html, contains('manifest.json?v=ae3'));
    expect(html, contains('favicon.ico?v=ae3'));
    expect(manifest['scope'], './');
    expect(manifest['start_url'], '.');
    final browserIcons = {16: '16', 32: '32', 48: '48', 180: 'apple-180'};
    for (final entry in browserIcons.entries) {
      final path = 'icons/ae-v3-${entry.value}.png';
      expect(html, contains(path));
      _expectPng(path, entry.key);
    }
    _expectPng('favicon.png', 32);
    final ico = ByteData.sublistView(File('web/favicon.ico').readAsBytesSync());
    expect(ico.getUint16(2, Endian.little), 1);
    expect(ico.getUint16(4, Endian.little), 3);
    expect(
      [for (var i = 0; i < 3; i++) ico.getUint8(6 + i * 16)],
      [16, 32, 48],
    );
    final icons = (manifest['icons'] as List).cast<Map<String, dynamic>>();
    expect(icons.where((icon) => icon['purpose'] == 'maskable'), hasLength(2));
    for (final icon in icons) {
      final size = int.parse((icon['sizes'] as String).split('x').first);
      expect(icon['type'], 'image/png');
      _expectPng(icon['src'] as String, size);
    }
  });
}

void _expectPng(String path, int expectedSize) {
  final data = ByteData.sublistView(File('web/$path').readAsBytesSync());
  expect(data.getUint32(0), 0x89504e47, reason: path);
  expect(data.getUint32(16), expectedSize, reason: path);
  expect(data.getUint32(20), expectedSize, reason: path);
}

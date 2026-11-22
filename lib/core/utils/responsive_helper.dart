import 'package:flutter/material.dart';

abstract final class PortfolioLayout {
  static const maxWidth = 1280.0;
  static const proseWidth = 680.0;
  static const minFullWidth = 320.0;
  static const minCompactWidth = 280.0;
  static const frostWidth = 1280.0;
  static const frostMaxPixels = 2_100_000;
  static const compact = 600.0;
  static const shortHeight = 500.0;
  static const split = 880.0;
  static const navigation = 1060.0;
  static const cardMin = 310.0;
  static const gap = 20.0;
  static const radius = 20.0;
  static const smallRadius = 10.0;

  static const fast = Duration(milliseconds: 160);
  static const filter = Duration(milliseconds: 240);
  static const reveal = Duration(milliseconds: 420);
  static const scroll = Duration(milliseconds: 500);
  static const ease = Curves.easeOutCubic;

  static double gutter(double width) {
    if (width < minFullWidth) return 12;
    return width < compact ? 20 : 36;
  }

  static double sectionSpace(double width) => width < compact ? 54 : 82;
}

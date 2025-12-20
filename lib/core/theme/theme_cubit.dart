import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    state == ThemeMode.light ? emit(ThemeMode.dark) : emit(ThemeMode.light);
  }
}

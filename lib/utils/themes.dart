import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class SolveTheme {
  final String name;
  final ThemeData data;

  const SolveTheme(this.name, this.data);
}

class ThemeBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<SolveTheme> selectedTheme;

  factory ThemeBloc() {
    final selectedTheme = PublishSubject<SolveTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);

    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  const ThemeBloc._(this.themeDataStream, this.selectedTheme);

  SolveTheme lightTheme() {
    return SolveTheme(
        'light',
        ThemeData(
            brightness: Brightness.light,
            accentColor: Colors.orange,
            primaryColor: Colors.deepPurple));
  }

  SolveTheme darkTheme() {
    return SolveTheme(
        'dark',
        ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.lightBlueAccent,
            primaryColor: Colors.pink));
  }
}

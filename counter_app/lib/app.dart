import 'package:flutter/material.dart';

import 'counter/counter.dart';

/// {@template counter_app}
/// {@endtemplate}
class CounterApp extends MaterialApp {
  /// {@macro counter_app}
  const CounterApp({Key key}) : super(key: key, home: const CounterPage());
}

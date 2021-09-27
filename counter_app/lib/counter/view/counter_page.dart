import 'package:counter_app/counter/cubit/cubit/countercubit_cubit.dart';
import 'package:counter_app/counter/view/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// counter page
class CounterPage extends StatelessWidget {
  /// macro counter page
  const CounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountercubitCubit(),
      child: CounterView(),
    );
  }
}

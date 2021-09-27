import 'package:bloc/bloc.dart';

/// counter cubit
/// which manage an int as its create
class CountercubitCubit extends Cubit<int> {
  /// macro counter cubit
  CountercubitCubit() : super(0);

  /// add 1 to current state
  void increment() => emit(state + 1);

  /// subtract 1 from current state
  void decrement() => emit(state - 1);
}

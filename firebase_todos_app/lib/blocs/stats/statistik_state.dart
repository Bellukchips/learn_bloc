import 'package:equatable/equatable.dart';

abstract class StatistikState extends Equatable {
  const StatistikState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatistikState {}

class StatsLoaded extends StatistikState {
  final int numActive;
  final int numCompleted;

  StatsLoaded(this.numActive, this.numCompleted);

  @override
  List<Object> get props => [numActive, numCompleted];

  @override
  String toString() {
    return "StatsLoaded {numActive: $numActive, numCompleted: $numCompleted}";
  }
}

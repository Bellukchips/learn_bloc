part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();
  
  @override
  List<Object> get props => [];
}

class TabsInitial extends TabsState {}

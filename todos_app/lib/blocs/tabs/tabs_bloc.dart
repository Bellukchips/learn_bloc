import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/models/tabs.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, AppTab> {
  TabsBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is TabsUpdated) {
      yield event.tab;
    }
  }
}

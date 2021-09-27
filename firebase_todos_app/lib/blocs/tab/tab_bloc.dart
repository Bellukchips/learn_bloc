import 'package:bloc/bloc.dart';
import 'package:firebase_todos_app/blocs/tab/tab.dart';
import 'package:firebase_todos_app/models/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos) {
    on<UpdateTab>((event, emit) => emit(event.tab));
  }
}

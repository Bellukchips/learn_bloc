import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:firebase_todos_app/models/models.dart';
import 'package:firebase_todos_app/screens/screens.dart';
import 'package:firebase_todos_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(builder: (ctx, activeTab) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Firestore Todos'),
          actions: [
            FilterButton(
              visible: activeTab == AppTab.todos,
            ),
            ExtraActions()
          ],
        ),
        body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => AddEditScreen(
                          isEditing: false,
                        )));
          },
          child: Icon(Icons.add),
          tooltip: 'Add Todo',
        ),
        bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                context.read<TabBloc>().add(UpdateTab(tab))),
      );
    });
  }
}

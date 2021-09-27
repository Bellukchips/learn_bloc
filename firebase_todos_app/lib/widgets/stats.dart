import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:firebase_todos_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_todos_app/models/models.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatistikBloc, StatistikState>(builder: (ctx, state) {
      if (state is StatsLoading) {
        return LoadingIndicator();
      } else if (state is StatsLoaded) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Completed Todos',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  '${state.numCompleted}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Active Todos',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "${state.numActive}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

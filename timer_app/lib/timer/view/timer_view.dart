import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../timer.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer'),
      ),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: TimerText(),
                ),
              ),
              ButtonTimer(),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonTimer extends StatelessWidget {
  const ButtonTimer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                onPressed: () {
                  context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: state.duration));
                },
                child: Icon(Icons.play_arrow),
              )
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerPaused());
                },
                child: Icon(Icons.pause),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerReset());
                },
                child: Icon(Icons.replay),
              ),
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerResumed());
                },
                child: Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerReset());
                },
                child: Icon(Icons.replay),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                onPressed: () {
                  context.read<TimerBloc>().add(TimerReset());
                },
                child: Icon(Icons.replay),
              )
            ]
          ],
        );
      },
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}

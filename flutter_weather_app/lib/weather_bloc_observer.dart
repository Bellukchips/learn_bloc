import 'package:bloc/bloc.dart';

class WeatherBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    print('onError $error');
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('onChange $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }
}

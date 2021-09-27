import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'blocs.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
  }

  void _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final isSignedIn = await _userRepository.isAuthenticated();
      if (!isSignedIn) await _userRepository.authenticated();
      String userId = _userRepository.getUserId().toString();
      emit(userId == null ? Unauthenticated() : Authenticated(userId));
    } catch (_) {
      emit(Unauthenticated());
    }
  }
}

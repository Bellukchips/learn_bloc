abstract class UserRepository {
  Future<bool> isAuthenticated();
  Future<void> authenticated();
  Future<String?>? getUserId();
}

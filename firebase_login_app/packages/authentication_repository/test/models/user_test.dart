import 'package:flutter_test/flutter_test.dart';
import 'package:authentication_repository/authentication_repository.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';

    //
    test('uses value equality', () {
      expect(const User(email: email, id: id),
          equals(const User(email: email, id: id)));
    });

    //test if users empty
    test('isEmpty returns true for empty user', () {
      expect(User.empty.isEmpty, isTrue);
    });

    // test if user not empty
    test('isEmpty returns false for non-empty user', () {
      const user = User(email: email, id: id);
      expect(user.isEmpty, isFalse);
    });

    // test return false for empty user
    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    // return true for nom-empty user
    test('isNotEmpty returns true for non-empty user', () {
      const user = User(email: email, id: id);
      expect(user.isNotEmpty, isTrue);
    });
  });
}

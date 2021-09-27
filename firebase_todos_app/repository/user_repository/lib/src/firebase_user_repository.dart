import 'package:user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository extends UserRepository {
  late final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  Future<void> authenticated() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth..currentUser;
    return currentUser != null;
  }

  @override
  Future<String> getUserId() async{
    return (await _firebaseAuth.currentUser)!.uid;
  }
}

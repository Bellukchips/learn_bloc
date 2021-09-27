import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

/// dijalankan jika proses daftar gagal

class SignUpFailure implements Exception {}

/// dijalankan jika proses masuk dengan email dan password gagal

class LoginWithEmailAndPasswordFailure implements Exception {}

/// dijalankan jika proses masuk sinkronisasi dengan akun google gagal

class LoginWithGoogleFailure implements Exception {}

/// dijalnkan jika proses keluar  gagal

class LogOutFailure implements Exception {}

/// authentication repository [class]
/// Repository yang mana mengatur autentikasi dari user

class AuthenticationRepository {
  ///@macro repository
  AuthenticationRepository(
      {CacheClient? cacheClient,
      firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn})
      : _cacheClient = cacheClient ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cacheClient;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// pengecekan apakah menggunakan web / tidak
  /// sebaiknya diganti untuk tujuan pengujian . Jika tidak
  /// pengaturan bawaan untuk [kIsWeb]

  @visibleForTesting
  bool isWeb = kIsWeb;

  /// kunci semestara pengguna
  /// sebaiknya hanya digunakan untuk tujuan pengujian
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// aliran pengguna akan mengembalikan pengguna yang terautentikasi
  /// mengembalikan nilai [User.empty] jika pengguna tidak terautentikasi

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cacheClient.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// mengambil cache user saat ini
  /// dengan pengaturan bawaan jika [User.empty] maka tidak ada cache user

  User get currentUser {
    return _cacheClient.read(key: userCacheKey) ?? User.empty;
  }

  /// membuat pengguna baru dengan data email dan password
  /// jika gagal maka akan menjalankan class [SignUpFailure]

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// masuk dengan akun google
  /// jika gagal maka akan menjalankan class [LoginWithGoogleFailure]
  Future<void> loginWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential =
            await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      }
      await _firebaseAuth.signInWithCredential(credential);
    } catch (_) {
      throw LoginWithGoogleFailure();
    }
  }

  /// masuk dengan email dan password
  // ignore: comment_references
  /// jika gagal maka akan menjalankan class [LoginWithEmailAndPassword]

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LoginWithEmailAndPasswordFailure();
    }
  }

  /// keluar / logout dengan user saat ini dimana nilai yang dikembalikan
  /// [User.empty] dari [user]
  ///
  // ignore: comment_references
  /// jika gagal maka akan menjalankan [LogoutFailure]

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}

import 'package:equatable/equatable.dart';

/// User Model
class User extends Equatable {
  /// constructor
  const User({
    this.email,
    this.id,
    this.name,
    this.photo,
  });

  /// get email user
  final String? email;

  /// get id user
  final String? id;

  /// get name user
  final String? name;

  /// get photo url user
  final String? photo;

  ///empty user which represents an unauthenticated user
  static const empty = User(id: '');

  /// checking current user is empty

  bool get isEmpty => this == User.empty;

  /// checking current user is not empty
  bool get isNotEmpty => this != User.empty;
  @override
  List<Object?> get props => [id, name, photo, email];
}

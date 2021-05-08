import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String userName;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.imageUrl,
    @required this.email,
    @required this.userName,
  });

  factory User.fromJson(Map map) {
    return User(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      imageUrl: map['last_name'],
      lastName: map['avatar_url'],
      userName: map['username'],
    );
  }
}

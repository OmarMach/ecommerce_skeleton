import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String userName;
  final String displayName;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.imageUrl,
    @required this.email,
    @required this.userName,
    @required this.displayName,
  });

  factory User.fromJson(Map map) {
    return User(
      id: map['id'].toString(),
      email: map['email'].toString(),
      firstName: map['first_name'].toString(),
      imageUrl: map['last_name'].toString(),
      lastName: map['avatar'].toString(),
      userName: map['username'].toString(),
      displayName: map['displayname'].toString(),
    );
  }

  Map toJSON() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': imageUrl,
      'avatar': lastName,
      'username': userName,
      'displayname': displayName,
    };
  }
}

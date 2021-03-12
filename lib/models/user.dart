import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String profileImageURL;
  final String email;
  final String phoneNumber;

  User({
    @required this.id,
    @required this.name,
    @required this.profileImageURL,
    @required this.email,
    @required this.phoneNumber,
  });
}

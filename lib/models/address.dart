import 'dart:convert';

import 'package:flutter/foundation.dart';

class Address {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  Address({
    @required this.firstName,
    @required this.lastName,
    @required this.address1,
    @required this.address2,
    @required this.city,
    @required this.state,
    @required this.postcode,
    @required this.country,
    @required this.email,
    @required this.phone,
  });

  factory Address.fromJSON(Map map) {
    return Address(
      firstName: map['first_name'],
      lastName: map['last_name'],
      address1: map['address_1'],
      address2: map['address_2'],
      city: map['city'],
      state: map['state'],
      postcode: map['postcode'],
      country: map['country'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode({
        'first_name': firstName.toString(),
        'last_name': lastName.toString(),
        'address_1': address1.toString(),
        'address_2': address2.toString(),
        'city': city.toString(),
        'state': state.toString(),
        'postcode': postcode.toString(),
        'country': country.toString(),
        'email': email.toString(),
        'phone': phone.toString(),
      });
}

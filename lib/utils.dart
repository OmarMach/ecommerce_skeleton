import 'package:flutter/material.dart';

const verticalSeparator = SizedBox(
  height: 10,
);

const horizontalSeparator = SizedBox(
  width: 10,
);
final buildAppBarSpacer = (Size size) => SizedBox(
      height: size.height / 12,
    );

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

// extension CapExtension on String {

//   String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

//   String get allInCaps => this.toUpperCase();

//   String get capitalizeFirstofEach =>
//       this.split(" ").map((str) => str.inCaps).join(" ");
// }

String emailValidator(String email) {
  if (notEmptyValidator(email) == null) if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email))
    return null;
  else
    return 'Please provide a valid email address.';
  else
    return notEmptyValidator(email);
}

String passwordValidator(String password) {
  if (password.isEmpty)
    return 'Please enter a password.';
  else if (password.length < 6)
    return 'Your Password must contain at least 6 characters.';
  else
    return null;
}

String phoneNumberValidator(String phone) {
  if (notEmptyValidator(phone) == null || phone.length == 8)
    return null;
  else
    return 'Please provide a valid phone number.';
}

String notEmptyValidator(String string) {
  if (string.isNotEmpty)
    return null;
  else
    return 'Please fill this field.';
}

final List<String> sortingListItem = [
  'Sort By Popularity',
  'Sort By Latest',
  'Sort By Title: A to Z',
  'Sort By Title: Z to A',
  'Sort By Price: Low to High',
  'Sort By Price: High to Low',
];

final List<DropdownMenuItem<String>> mappedSortingListItems =
    sortingListItem.map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
  );
}).toList();

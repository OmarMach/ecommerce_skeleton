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

// extension CapExtension on String {

//   String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

//   String get allInCaps => this.toUpperCase();

//   String get capitalizeFirstofEach =>
//       this.split(" ").map((str) => str.inCaps).join(" ");
// }

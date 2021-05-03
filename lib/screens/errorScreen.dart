import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({Key key, @required this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 250,
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

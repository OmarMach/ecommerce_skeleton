import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({Key key, @required this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerMenuWidget(),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: Column(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

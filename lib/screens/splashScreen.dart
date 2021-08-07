import 'package:ecommerce_app/utils.dart';
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
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.contain,
        //     repeat: ImageRepeat.repeat,
        //     image: AssetImage('assets/images/background.jpg'),
        //   ),
        // ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/Logo.png',
                    width: size.width * .8,
                  ),
                ),
                verticalSeparator,
                Container(
                  width: size.width / 2,
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

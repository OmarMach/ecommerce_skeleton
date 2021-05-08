import 'package:ecommerce_app/screens/loginScreen.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class NotconnectedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.person,
          size: 100,
          color: Colors.white,
        ),
        Text(
          "My account",
          style: textTheme.headline4,
        ),
        Text(
          "To access this section you need to login or register..",
          style: textTheme.caption,
        ),
        SizedBox(
          width: size.width / 1.2,
          child: Divider(
            color: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text("Register"),
              ),
              horizontalSeparator,
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

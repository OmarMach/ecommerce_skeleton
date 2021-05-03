import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
    );
  }
}

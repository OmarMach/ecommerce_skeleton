import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/registerScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _credentials = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerMenuWidget(),
      body: SizedBox(
        height: size.height,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/Logo.png',
                    height: size.height / 4,
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSeparator,
                        ListView(
                          shrinkWrap: true,
                          children: [
                            // Email text field
                            TextFormField(
                              onSaved: (value) {
                                _credentials['email'] = value.toString().trim();
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: buildFormInputDecoration(
                                icon: Icons.alternate_email,
                                hint: "Email..",
                                label: 'Email Address..',
                              ),
                              validator: (value) => value.contains('@')
                                  ? null
                                  : 'Please enter a valid Email address..',
                            ),
                            verticalSeparator,
                            // Password textfield
                            TextFormField(
                              onSaved: (value) {
                                _credentials['password'] =
                                    value.toString().trim();
                              },
                              obscureText: true,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : 'Please enter a password..',
                              decoration: buildFormInputDecoration(
                                icon: Icons.lock,
                                hint: "Password...",
                                label: 'Password',
                              ),
                            ),
                            verticalSeparator,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      final SnackBar snackBar = SnackBar(
                                          content: Text("Sorry for you.."));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text(
                                      "Forgot password?",
                                      textAlign: TextAlign.right,
                                      style: textTheme.caption,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSeparator,
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              final results = await userProvider.login(
                                _credentials['email'],
                                _credentials['password'],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Success'),
                                  content: Text(results),
                                ),
                              );
                            }
                          },
                          child: Text("Login"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text("Create an account"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(HomeScreen.routeName);
                          },
                          child: Text(
                            "Continue without logging in",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: googleColor,
                        side: BorderSide(color: googleColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(FontAwesome.google),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Use your Google Account",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: facebookColor,
                        side: BorderSide(
                          color: facebookColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesome.facebook_official,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Use your Facebook account",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildFormInputDecoration({
    IconData icon,
    String hint,
    String label,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon) ?? null,
      hintText: hint ?? '',
      labelText: label ?? '',
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(),
      ),
    );
  }
}

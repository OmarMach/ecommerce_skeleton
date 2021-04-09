import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../config.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _credentials = {};

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    // TODO : fix the values
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      verticalSeparator,
                      Image.asset(
                        "assets/images/logoMobile.png",
                        width: size.width / 3,
                        height: size.width / 2,
                        fit: BoxFit.contain,
                      ),
                      verticalSeparator,
                      ListView(
                        shrinkWrap: true,
                        children: [
                          // Email text field
                          TextFormField(
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

                            _credentials['email'] =
                                _emailController.text.toString().trim();
                            _credentials['password'] = _passwordController.text;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Success'),
                                content: Text(
                                  'Successfully logged in.' +
                                      _passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Login"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Create an account"),
                      ),
                      Divider(),
                      verticalSeparator,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                      Divider(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          side: BorderSide(color: Colors.grey),
                        ),
                        child: Text(
                          "Continue without logging in",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/WrapperScreen.dart';
import 'package:ecommerce_app/screens/registerScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _credentials = {
    'email': 'soulaamal256@gmail.com',
    'password': 'azerty123',
    'username': 'omarmachhouty'
  };

  bool _isLoading = false;
  bool _error = false;
  String _errorMessage = '';

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
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                repeat: ImageRepeat.repeat,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
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
                                  _credentials['email'] =
                                      value.toString().trim();
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: buildFormInputDecoration(
                                  icon: Icons.alternate_email,
                                  hint: "Email Address..",
                                  label: 'Email',
                                ),
                                validator: emailValidator,
                              ),
                              verticalSeparator,
                              // Password textfield
                              TextFormField(
                                obscureText: true,
                                onSaved: (value) {
                                  _credentials['password'] =
                                      value.toString().trim();
                                },
                                // obscureText: true,
                                validator: passwordValidator,
                                decoration: buildFormInputDecoration(
                                  icon: Icons.lock,
                                  hint: "Password...",
                                  label: 'Password',
                                ),
                              ),
                              if (_error)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "$_errorMessage",
                                    style: textTheme.caption.copyWith(
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              verticalSeparator,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        launch(
                                            'https://goods.tn/my-account/lost-password/');
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
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      _isLoading = true;
                                      setState(() {});

                                      try {
                                        await userProvider.login(
                                          email: _credentials['email'],
                                          password: _credentials['password'],
                                        );
                                        _error = false;
                                      } catch (e) {
                                        _error = true;
                                        _errorMessage = e.toString();
                                        print(e.toString());
                                      }

                                      _isLoading = false;
                                      setState(() {});

                                      if (userProvider.isConnected) {
                                        Navigator.of(context).popUntil(
                                          ModalRoute.withName(
                                              WrapperScreen.routeName),
                                        );
                                        Navigator.of(context)
                                            .pushNamed(WrapperScreen.routeName);
                                      }
                                    }
                                  },
                            child: _isLoading
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Text("Login"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                RegisterScreen.routeName,
                              );
                            },
                            child: Text("Create an account"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                WrapperScreen.routeName,
                              );
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
                        onPressed: () async {
                          final LoginResult result =
                              await FacebookAuth.instance.login();
                          print(result.message);
                          if (result.status == LoginStatus.success) {
                            final AccessToken accessToken = result.accessToken;
                            print(accessToken);
                          } else
                            print(result.status);
                        },
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

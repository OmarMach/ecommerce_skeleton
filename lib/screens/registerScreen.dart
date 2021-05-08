import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Register",
                  style: textTheme.headline4,
                ),
                Text(
                  "Please fill the form to create an account.",
                  style: textTheme.caption,
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    email = value.toString().trim();
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      userProvider.registerUser(email);
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success'),
                          content: Text(email ?? ''),
                        ),
                      );
                    }
                  },
                  child: Text("Create Account"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "An email will be sent containing the password.",
                    style: textTheme.bodyText1,
                  ),
                ),
                verticalSeparator,
                Text(
                  "Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our privacy policy..",
                  style: textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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

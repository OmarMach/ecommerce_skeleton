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
  String password;

  bool _isLoading;
  bool _error;
  String _errorMessage = '';
  UserProvider userProvider;
  TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _error = false;
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(_isLoading);
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
                verticalSeparator,
                TextFormField(
                  initialValue: 'soulaamal256@gmail.com',
                  onSaved: (value) {
                    email = value.toString().trim();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildFormInputDecoration(
                    icon: Icons.alternate_email,
                    hint: "Email",
                    label: 'Email Address',
                  ),
                  validator: (value) => value.contains('@')
                      ? null
                      : 'Please enter a valid Email address',
                ),
                verticalSeparator,
                TextFormField(
                  obscureText: true,
                  initialValue: 'azerty123',
                  onSaved: (value) {
                    password = value.toString();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildFormInputDecoration(
                    icon: Icons.lock,
                    hint: "Password",
                    label: 'Password',
                  ),
                  validator: (value) => value.length > 6
                      ? null
                      : 'The password needs to have at least 6 characters',
                ),
                verticalSeparator,
                TextFormField(
                  obscureText: true,
                  initialValue: 'azerty123',
                  onSaved: (value) {
                    password = value.toString();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildFormInputDecoration(
                    icon: Icons.lock,
                    hint: "Confirm Password",
                    label: 'Confirm Password',
                  ),
                  validator: (value) =>
                      password == value ? null : 'The passwords doesn\'t match',
                ),
                if (_error)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: textTheme.caption.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      _isLoading = true;
                      setState(() {});
                      try {
                        bool isRegistred =
                            await userProvider.registerUser(email, password);
                        if (!isRegistred) throw ('e');
                      } catch (e) {
                        _error = true;
                        _errorMessage = e;
                      }
                      _isLoading = false;
                      setState(() {});
                    }
                  },
                  child: _isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text("Create Account"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your personal data will be used to support your experience throughout this applicaiton, to manage access to your account, and for other purposes described in our privacy policy..",
                    style: textTheme.caption,
                    textAlign: TextAlign.justify,
                  ),
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

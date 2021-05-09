import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class EditAccountDetails extends StatelessWidget {
  static const routeName = '/editAccDetails';

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _credentials = {};

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Edit Account details",
                      textAlign: TextAlign.center,
                      style: textTheme.headline4,
                    ),
                    verticalSeparator,
                    verticalSeparator,
                    EditAccountDetailsSectionTitleWidget(
                      textTheme: textTheme,
                      label: 'Customer Information',
                    ),
                    verticalSeparator,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: user?.firstName ?? '',
                            onSaved: (value) {
                              _credentials['firstName'] =
                                  value.toString().trim();
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: buildFormInputDecoration(
                              hint: "First Name..",
                              label: 'First Name',
                            ),
                            validator: (value) => value.isNotEmpty
                                ? null
                                : 'Please enter First Name address..',
                          ),
                        ),
                        horizontalSeparator,
                        Expanded(
                          child: TextFormField(
                            initialValue: user?.lastName ?? '',
                            onSaved: (value) {
                              _credentials['lastName'] =
                                  value.toString().trim();
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: buildFormInputDecoration(
                              hint: "Last Name..",
                              label: 'Last Name',
                            ),
                            validator: (value) => value.isNotEmpty
                                ? null
                                : 'Please enter a last Name address..',
                          ),
                        ),
                      ],
                    ),
                    verticalSeparator,
                    TextFormField(
                      initialValue: user?.firstName ?? '',
                      onSaved: (value) {
                        _credentials['displayName'] = value.toString().trim();
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: buildFormInputDecoration(
                        hint: "Display Name..",
                        label: 'Display Name',
                      ),
                      validator: (value) => value.isNotEmpty
                          ? null
                          : 'Please enter a last Name address..',
                    ),
                    verticalSeparator,
                    EditAccountDetailsSectionTitleWidget(
                      textTheme: textTheme,
                      label: 'Login credentials',
                    ),
                    TextFormField(
                      initialValue: user?.email ?? '',
                      onSaved: (value) {
                        _credentials['email'] = value.toString().trim();
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: buildFormInputDecoration(
                        icon: Icons.alternate_email,
                        hint: "Email",
                        label: 'Email Address',
                      ),
                      validator: (value) => value.contains('@')
                          ? null
                          : 'Please enter a valid Email address..',
                    ),
                    verticalSeparator,
                    TextFormField(
                      onSaved: (value) {
                        _credentials['oldPassword'] = value.toString();
                      },
                      obscureText: true,
                      // validator: (value) =>
                      //     value.isNotEmpty ? null : 'Please enter a password..',
                      decoration: buildFormInputDecoration(
                        icon: Icons.lock,
                        hint: "Old Password...",
                        label: 'Old Password',
                      ),
                    ),
                    verticalSeparator,
                    TextFormField(
                      onSaved: (value) {
                        _credentials['password'] = value.toString();
                      },
                      obscureText: true,
                      // validator: (value) =>
                      //     value.isEmpty ? null : 'Please enter a password..',
                      decoration: buildFormInputDecoration(
                        icon: Icons.lock_open,
                        hint: "New Password...",
                        label: 'New Password',
                      ),
                    ),
                    verticalSeparator,
                    TextFormField(
                      obscureText: true,
                      validator: (value) => value.isEmpty
                          ? null
                          : _credentials['password'] != value
                              ? 'The passwords doesn\'t match.'
                              : null,
                      decoration: buildFormInputDecoration(
                        icon: Icons.lock_open,
                        hint: "New Password...",
                        label: 'New Password',
                      ),
                    ),
                    verticalSeparator,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade900,
                      ),
                      child: Text("Save Changes"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditAccountDetailsSectionTitleWidget extends StatelessWidget {
  const EditAccountDetailsSectionTitleWidget({
    Key key,
    @required this.textTheme,
    @required this.label,
  }) : super(key: key);

  final TextTheme textTheme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(),
          ),
          Text(
            label,
            style: textTheme.caption,
          ),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

InputDecoration buildFormInputDecoration({
  IconData icon,
  String hint,
  String label,
}) {
  if (icon != null)
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint ?? '',
      labelText: label ?? '',
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(),
      ),
    );
  else
    return InputDecoration(
      hintText: hint ?? '',
      labelText: label ?? '',
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(),
      ),
    );
}

import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'editAccountDetails.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add-address';
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _credentials = {};

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Address Management",
                  textAlign: TextAlign.center,
                  style: textTheme.headline4,
                ),
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
                        onSaved: (value) {
                          _credentials['firstName'] = value.toString().trim();
                        },
                        decoration: buildFormInputDecoration(
                          hint: "First Name..",
                          label: 'First Name',
                        ),
                        validator: (value) =>
                            value.isNotEmpty ? null : 'Please enter First Name',
                      ),
                    ),
                    horizontalSeparator,
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) {
                          _credentials['lastName'] = value.toString().trim();
                        },
                        decoration: buildFormInputDecoration(
                          hint: "Last Name..",
                          label: 'Last Name',
                        ),
                        validator: (value) => value.isNotEmpty
                            ? null
                            : 'Please enter a last Name',
                      ),
                    ),
                  ],
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    _credentials['phone'] = value.toString().trim();
                  },
                  keyboardType: TextInputType.phone,
                  decoration: buildFormInputDecoration(
                    hint: "Phone..",
                    label: 'Phone',
                  ),
                  validator: (value) => value.isNotEmpty
                      ? value.length == 8
                          ? null
                          : 'Please enter a valid phone number'
                      : 'Please enter a phone number',
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    _credentials['firstName'] = value.toString().trim();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildFormInputDecoration(
                    hint: "Email ..",
                    label: 'Email ',
                  ),
                  validator: (value) => value.isNotEmpty
                      ? null
                      : 'Please enter an email address..',
                ),
                verticalSeparator,
                EditAccountDetailsSectionTitleWidget(
                  textTheme: textTheme,
                  label: 'Address',
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    _credentials['street'] = value.toString().trim();
                  },
                  keyboardType: TextInputType.streetAddress,
                  decoration: buildFormInputDecoration(
                    hint: "Street Address ..",
                    label: 'Street Address ',
                  ),
                  validator: (value) => value.isNotEmpty
                      ? null
                      : 'Please enter a street address..',
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    _credentials['town'] = value.toString().trim();
                  },
                  keyboardType: TextInputType.streetAddress,
                  decoration: buildFormInputDecoration(
                    hint: "Town/city  ..",
                    label: 'Town/city  ',
                  ),
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Please enter a Toww/city ..',
                ),
                verticalSeparator,
                TextFormField(
                  onSaved: (value) {
                    _credentials['zip'] = value.toString().trim();
                  },
                  keyboardType: TextInputType.number,
                  decoration: buildFormInputDecoration(
                    hint: "Zip Code  ..",
                    label: 'Zip Code  ',
                  ),
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Please enter a Zip Code ..',
                ),
                verticalSeparator,
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade900,
                  ),
                  child: Text("Save Address"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/addressesScreen.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'editAccountDetails.dart';

class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add-address';

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _credentials = {};

  @override
  Widget build(BuildContext context) {
    final initialAddress =
        Provider.of<UserProvider>(context, listen: false).userAddress;
    final textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: SingleChildScrollView(
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
                            initialValue: initialAddress?.firstName ?? '',
                            onSaved: (value) {
                              _credentials['first_name'] =
                                  value.toString().trim();
                            },
                            decoration: buildFormInputDecoration(
                              hint: "First Name..",
                              label: 'First Name',
                            ),
                            validator: (value) => value.isNotEmpty
                                ? null
                                : 'Please enter First Name',
                          ),
                        ),
                        horizontalSeparator,
                        Expanded(
                          child: TextFormField(
                            initialValue: initialAddress?.lastName ?? '',
                            onSaved: (value) {
                              _credentials['last_name'] =
                                  value.toString().trim();
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
                      initialValue: initialAddress?.phone ?? '',
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
                      initialValue: initialAddress?.email ?? '',
                      onSaved: (value) {
                        _credentials['email'] = value.toString().trim();
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
                      enabled: false,
                      initialValue: 'Tunisia',
                      onSaved: (value) {
                        _credentials['country'] = value.toString().trim();
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: buildFormInputDecoration(
                        hint: "Country ..",
                        label: 'Country ',
                      ),
                    ),
                    verticalSeparator,
                    TextFormField(
                      initialValue: initialAddress?.address1 ?? '',
                      onSaved: (value) {
                        _credentials['address_1'] = value.toString().trim();
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
                      initialValue: initialAddress?.address2 ?? '',
                      onSaved: (value) {
                        _credentials['address_2'] = value.toString().trim();
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: buildFormInputDecoration(
                        hint: "Town/city  ..",
                        label: 'Town/city  ',
                      ),
                      validator: (value) => value.isNotEmpty
                          ? null
                          : 'Please enter a Toww/city ..',
                    ),
                    verticalSeparator,
                    TextFormField(
                      initialValue: initialAddress?.postcode ?? '',
                      onSaved: (value) {
                        _credentials['postcode'] = value.toString().trim();
                      },
                      keyboardType: TextInputType.number,
                      decoration: buildFormInputDecoration(
                        hint: "Zip Code  ..",
                        label: 'Zip Code  ',
                      ),
                      validator: (value) => value.isNotEmpty
                          ? null
                          : 'Please enter a Zip Code ..',
                    ),
                    verticalSeparator,
                    Divider(),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                "Are you sure that you want add this address?",
                              ),
                              title: Text(
                                "Address",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await Provider.of<UserProvider>(context,
                                            listen: false)
                                        .createAddress(_credentials);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context).popAndPushNamed(
                                        AddressesScreen.routeName);
                                  },
                                  child: Text("OK"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      onLongPress: () {
                        Map<String, String> map = {
                          "first_name": "Testing",
                          "last_name": "On Mobile",
                          "address_1": "969 Market",
                          "address_2": "",
                          "city": "San Francisco",
                          "state": "CA",
                          "postcode": "94103",
                          "country": "TUN",
                          "email": "Omarmachhouty@gmail.com",
                          "phone": "21244434"
                        };
                        Provider.of<UserProvider>(context, listen: false)
                            .createAddress(map);
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
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/AddAddressScreen.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesScreen extends StatelessWidget {
  static const routeName = '/addresses';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                userProvider.userAddress != null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Billing Address",
                              textAlign: TextAlign.center,
                              style: textTheme.headline5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "This address will be auto filled for each new order.",
                              style: textTheme.caption,
                            ),
                          ),
                          AddressWidget(
                            textTheme: textTheme,
                            address: userProvider.userAddress,
                          ),
                        ],
                      )
                    : NoAddressWidget(textTheme: textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoAddressWidget extends StatelessWidget {
  const NoAddressWidget({
    Key key,
    @required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.home, size: 80),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Billing Address",
            textAlign: TextAlign.center,
            style: textTheme.headline5,
          ),
        ),
        Text(
          "This address will be auto filled for each new order.",
          style: textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddAddressScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade700,
          ),
          child: Text("Add Address"),
        ),
      ],
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key key,
    @required this.textTheme,
    @required this.address,
  }) : super(key: key);

  final TextTheme textTheme;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressItemWidget(
              label: 'Full name',
              value: (address.firstName + ' ' + address.lastName ?? ''),
            ),
            AddressItemWidget(
              label: 'Email Address',
              value: address.email ?? '',
            ),
            AddressItemWidget(
              label: 'Country',
              value: address.country ?? '',
            ),
            AddressItemWidget(
              label: 'Street Address',
              value: address.address1 ?? '',
            ),
            AddressItemWidget(
              label: 'Town/City',
              value: address.address2 ?? '',
            ),
            AddressItemWidget(
              label: 'Zip code',
              value: address.postcode ?? '',
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddAddressScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade700,
              ),
              child: Text("Edit Address"),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

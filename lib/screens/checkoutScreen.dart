import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/orderCartItemsWidget.dart';
import 'package:ecommerce_app/widgets/stepWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DeliveryType { pickup, delivery }

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DeliveryType _delivery = DeliveryType.pickup;
  bool _terms = false;
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
  void initState() {
    _delivery = DeliveryType.pickup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Calling the cart provider
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final cart = cartProvider.items;
    final user = userProvider.user;
    final address = userProvider.userAddress;
    final _isCartEmpty = cart.length > 0 ? false : true;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: _isCartEmpty
          ? EmptyCartCheckoutWidget()
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StepWidget(step: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Payement information..",
                        style: textTheme.headline5,
                      ),
                    ),
                    Divider(),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => phoneNumberValidator(value),
                      initialValue: address.phone,
                      decoration: buildFilledGreyInputDecoration(
                        inputLabel: "Phone *",
                      ),
                    ),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => emailValidator(value),
                      initialValue: address.email,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Email address *"),
                    ),
                    verticalSeparator,
                    Divider(),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.firstName,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "First name *"),
                    ),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.lastName,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Last name *"),
                    ),
                    verticalSeparator,
                    Divider(),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.address1,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Adress * "),
                    ),
                    verticalSeparator,
                    TextFormField(
                      initialValue: address.address2,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Apartment, suite, unit, etc. "),
                    ),
                    verticalSeparator,
                    Divider(),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.city,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Town/City *"),
                    ),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.state,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "State/Country *"),
                    ),
                    verticalSeparator,
                    TextFormField(
                      validator: (value) => notEmptyValidator(value),
                      initialValue: address.postcode,
                      decoration: buildFilledGreyInputDecoration(
                          inputLabel: "Post Code/ Zip *"),
                    ),
                    verticalSeparator,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Payement information..",
                        style: textTheme.headline5,
                      ),
                    ),
                    Divider(),
                    verticalSeparator,
                    ListView.builder(
                      itemCount: cart.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => OrderCartItemsWidget(
                        cartItem: cart.values.elementAt(index),
                      ),
                    ),
                    verticalSeparator,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.shade800,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subtotal"),
                                  Text(cartProvider.total.toString() + " Tnd"),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Shipping"),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: DeliveryType.delivery,
                                  groupValue: _delivery,
                                  onChanged: (DeliveryType value) {
                                    setState(() {
                                      _delivery = value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _delivery = DeliveryType.delivery;
                                      });
                                    },
                                    child: Text("Delivery"),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: DeliveryType.pickup,
                                  groupValue: _delivery,
                                  onChanged: (DeliveryType value) {
                                    setState(() {
                                      _delivery = value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _delivery = DeliveryType.pickup;
                                      });
                                    },
                                    child: Text("Personal Pickup"),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total"),
                                  Text(cartProvider.total.toString() + " Tnd"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSeparator,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                groupValue: null,
                                onChanged: (Null value) {},
                                value: null,
                              ),
                              Text("Cash on delivery")
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Pay with cash upon delivery or local pickup.",
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSeparator,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: _terms,
                          onChanged: (value) {
                            setState(() {
                              _terms = value;
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _terms = !_terms;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "I have read and agreed the application's Terms and conditions.",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSeparator,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                      ),
                      onPressed: () async {
                        _isLoading = true;
                        setState(() {});
                        try {
                          // userProvider.createOrder(
                          //   cartItems: cartProvider.items,
                          //   address: userProvider.userAddress,
                          // );
                          await userProvider.getUserOrders();
                        } catch (e) {
                          _error = true;
                          _errorMessage = e.toString();
                        }
                        _isLoading = false;
                        setState(() {});
                      },
                      child: _isLoading
                          ? LinearProgressIndicator()
                          : Text('Palce Order'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  InputDecoration buildFilledGreyInputDecoration({
    @required String inputLabel,
    String hint = "",
    IconData prefixIcon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      filled: true,
      hintText: hint,
      labelText: inputLabel,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    );
  }
}

class EmptyCartCheckoutWidget extends StatelessWidget {
  const EmptyCartCheckoutWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart_outlined, size: 100),
            ),
            Text("Please add items to your cart to proceed for checkout."),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SearchScreen.routeName);
              },
              child: Text("Browse Products"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/ordersScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/orderCartItemsWidget.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map _orderDetails = {
    "first_name": "",
    "last_name": "",
    "address_1": "",
    "address_2": "",
    "city": "",
    "state": "",
    "postcode": "",
    "country": "",
    "email": "",
    "phone": "",
  };

  bool _isLoading = false;

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

    final userInfo = userProvider.userAddress;
    final cart = cartProvider.items;

    final _isCartEmpty = cart.length > 0 ? false : true;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: _isCartEmpty
            ? EmptyCartCheckoutWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          validator: phoneNumberValidator,
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.phone
                              : '',
                          onSaved: (value) => _orderDetails['phone'] = value,
                          decoration: buildFilledGreyInputDecoration(
                            inputLabel: "Phone *",
                          ),
                        ),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => emailValidator(value),
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.email
                              : '',
                          onSaved: (value) => _orderDetails['email'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "Email address *"),
                        ),
                        verticalSeparator,
                        Divider(),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => notEmptyValidator(value),
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.firstName
                              : '',
                          onSaved: (value) =>
                              _orderDetails['first_name'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "First name *"),
                        ),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => notEmptyValidator(value),
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.lastName
                              : '',
                          onSaved: (value) =>
                              _orderDetails['last_name'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "Last name *"),
                        ),
                        verticalSeparator,
                        Divider(),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => notEmptyValidator(value),
                          onSaved: (value) =>
                              _orderDetails['address_1'] = value,
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.address1
                              : '',
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "Adress * "),
                        ),
                        verticalSeparator,
                        TextFormField(
                          onSaved: (value) =>
                              _orderDetails['address_2'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "Apartment, suite, unit, etc. "),
                        ),
                        verticalSeparator,
                        Divider(),
                        verticalSeparator,
                        TextFormField(
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.address2
                              : '',
                          validator: (value) => notEmptyValidator(value),
                          onSaved: (value) => _orderDetails['city'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "Town/City *"),
                        ),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => notEmptyValidator(value),
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.state
                              : '',
                          onSaved: (value) => _orderDetails['address'] = value,
                          decoration: buildFilledGreyInputDecoration(
                              inputLabel: "State/Country *"),
                        ),
                        verticalSeparator,
                        TextFormField(
                          validator: (value) => notEmptyValidator(value),
                          initialValue: userProvider.userAddress != null
                              ? userProvider.userAddress.postcode
                              : '20920',
                          onSaved: (value) => _orderDetails['postcode'] = value,
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
                                      Text(cartProvider.total.toString() +
                                          " Tnd"),
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
                                          cartProvider.isDelivery = true;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _delivery = DeliveryType.delivery;
                                            cartProvider.isDelivery = true;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Delivery"),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: cartProvider.total > 300
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          "10.00 Tnd",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        ),
                                                        Text(" 0 Tnd"),
                                                      ],
                                                    )
                                                  : Text("10.00 Tnd"),
                                            ),
                                          ],
                                        ),
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
                                          cartProvider.isDelivery = false;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _delivery = DeliveryType.pickup;
                                            cartProvider.isDelivery = false;
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
                                      Text((cartProvider.total +
                                                  (cartProvider.isDelivery
                                                      ? (cartProvider.total <
                                                              300.00
                                                          ? 10.00
                                                          : 0)
                                                      : 0))
                                              .toString() +
                                          " Tnd"),
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
                            print("pressed");
                            _isLoading = true;
                            setState(() {});

                            Future.delayed(Duration(seconds: 1));

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (_terms) {
                                Map deliveryRates = {};
                                if (cartProvider.isDelivery) {
                                  if (cartProvider.total >= 300.0)
                                    deliveryRates = {
                                      "method_id": "free_shipping",
                                      "method_title": "Free shipping",
                                      "total": "0"
                                    };
                                  else
                                    deliveryRates = {
                                      "method_id": "flat_rate",
                                      "method_title": "Delivery by \"Aramex\"",
                                      "total": "10.00"
                                    };
                                } else
                                  deliveryRates = {
                                    "method_id": "local_pickup",
                                    "method_title": "Local pickup",
                                    "total": "0"
                                  };

                                final isCreated =
                                    await userProvider.createOrder(
                                  address: _orderDetails,
                                  cartItems: cart,
                                  deliveryRates: deliveryRates,
                                );

                                if (isCreated)
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Order details"),
                                      content: Text(
                                        "Your order has been successfully created.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.of(context).pushNamed(
                                              OrdersScreen.routeName,
                                            );
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                else
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                        "An error occured when creating your order, please try again later.",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                              } else
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Required information"),
                                    content: Text(
                                      "You need to accept the application's terms and conditions.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                            } else
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Required information"),
                                  content: Text(
                                    "Please fill the required information to validate your order.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );

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

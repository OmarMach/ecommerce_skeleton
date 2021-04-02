import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/stepWidget.dart';
import 'package:flutter/material.dart';

enum DeliveryType { pickup, delivery }

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DeliveryType _delivery = DeliveryType.pickup;
  bool _terms = false;

  @override
  void initState() {
    _delivery = DeliveryType.pickup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing and shipping"),
      ),
      body: Padding(
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
                decoration: buildFilledGreyInputDecoration(
                  inputLabel: "Phone *",
                ),
              ),
              verticalSeparator,
              TextFormField(
                decoration: buildFilledGreyInputDecoration(
                    inputLabel: "Email address *"),
              ),
              verticalSeparator,
              Divider(),
              verticalSeparator,
              TextFormField(
                decoration:
                    buildFilledGreyInputDecoration(inputLabel: "First name *"),
              ),
              verticalSeparator,
              TextFormField(
                decoration:
                    buildFilledGreyInputDecoration(inputLabel: "Last name *"),
              ),
              verticalSeparator,
              Divider(),
              verticalSeparator,
              TextFormField(
                decoration:
                    buildFilledGreyInputDecoration(inputLabel: "Adress * "),
              ),
              verticalSeparator,
              TextFormField(
                decoration: buildFilledGreyInputDecoration(
                    inputLabel: "Apartment, suite, unit, etc. "),
              ),
              verticalSeparator,
              Divider(),
              verticalSeparator,
              TextFormField(
                decoration:
                    buildFilledGreyInputDecoration(inputLabel: "Town/City *"),
              ),
              verticalSeparator,
              TextFormField(
                decoration: buildFilledGreyInputDecoration(
                    inputLabel: "State/Country *"),
              ),
              verticalSeparator,
              TextFormField(
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
                itemCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.grey.shade900,
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.grey.shade800,
                          ),
                          horizontalSeparator,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://goods.tn/wp-content/uploads/2021/02/%E8%AF%A6%E6%83%85%E9%A1%B5_01.jpg",
                              height: size.width / 6,
                              width: size.width / 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Product title",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "A cart Item, this is a product titleA cart Item, this is a product title..",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("25.00 TND"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            child: Text("X 5"),
                                            backgroundColor:
                                                Colors.grey.shade800,
                                          ),
                                        ),
                                      ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal"),
                            Text("100.000 Tnd"),
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
                          Text("Delivery")
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
                          Text("Personal Pickup")
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Text("125.000 tnd"),
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
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have read an gree the application's Terms and conditions *"),
                    ),
                  )
                ],
              ),
              verticalSeparator,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade800,
                ),
                onPressed: () {},
                child: Text('Palce Order'),
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

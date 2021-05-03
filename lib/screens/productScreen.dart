import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/widgets/ProductImagesCarousel.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../utils.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final product = ModalRoute.of(context).settings.arguments as WooProduct;

    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blueGrey.shade700,
                child: Column(
                  children: [
                    ProductImagesCarousel(items: product.images),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Product Title
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        product.name,
                        style: textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Price and stock
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${product.price} TND - ",
                          textAlign: TextAlign.center,
                          style: textTheme.subtitle1.copyWith(
                            color: Colors.green,
                          ),
                        ),
                        if (product.stockStatus != 'instock')
                          Text(
                            'Out of stock',
                            style: textTheme.subtitle1.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        if (product.stockStatus == 'instock')
                          Text(
                            'In stock',
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1.copyWith(
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                    Divider(),
                    // Add to cart Buttons
                    if (product.stockStatus == 'instock')
                      AddToCartButtons(
                        product: product,
                      ),
                    if (product.stockStatus != 'instock') NotifyMeWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Item Added to the favorites.."),
                                  ),
                                );
                                Provider.of<FavoritesProvider>(context,
                                        listen: false)
                                    .addToFavorites(product);
                              },
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_outline,
                                        color: Colors.green,
                                      ),
                                      horizontalSeparator,
                                      Text("Add to Wish list"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    // Aramex
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline_outlined),
                          horizontalSeparator,
                          Text(
                            "All products will be delivered by \"Aramex\".",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline_outlined),
                          horizontalSeparator,
                          Text(
                            "We also provide the possibility of local pickup.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    // Product description
                    if (removeAllHtmlTags(product.description)
                        .trim()
                        .replaceAll('\n\n', '\n')
                        .isNotEmpty) ...[
                      Divider(),
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: textTheme.headline5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          removeAllHtmlTags(product.description)
                                  .trim()
                                  .replaceAll('\n\n', '\n') +
                              ".",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                    Divider(),
                    // Similar products
                    Text(
                      "Similar products",
                      textAlign: TextAlign.start,
                      style: textTheme.headline5,
                    ),
                    verticalSeparator,
                    ProductsByCategoryGridList(
                      categoryId: product.categories[0].id,
                      limit: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToCartButtons extends StatefulWidget {
  final WooProduct product;
  const AddToCartButtons({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _AddToCartButtonsState createState() => _AddToCartButtonsState();
}

class _AddToCartButtonsState extends State<AddToCartButtons> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: new OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        int parsedValue = int.tryParse(value.toString());
                        if (parsedValue == null || parsedValue <= 0)
                          return "";
                        else
                          return null;
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        int quantity = int.tryParse(
                          _controller.text.toString(),
                        );
                        if (quantity == null) quantity = 1;
                        if (_formKey.currentState.validate()) if (widget
                                .product.stockQuantity >
                            quantity) quantity++;

                        _controller.text = quantity.toString();
                        setState(() {});
                      },
                      child: Icon(Icons.keyboard_arrow_up_rounded),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      int quantity = int.tryParse(
                        _controller.text.toString(),
                      );
                      if (quantity == null) quantity = 1;
                      if (_formKey.currentState.validate() && quantity > 1)
                        --quantity;

                      _controller.text = quantity.toString();
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 30,
                      width: 60,
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Material(
              color: widget.product.stockStatus == 'instock'
                  ? Colors.grey
                  : Colors.redAccent.shade100,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: widget.product.stockStatus != 'instock'
                    ? null
                    : () {
                        if (_formKey.currentState.validate()) {
                          if (widget.product.stockQuantity >
                              int.tryParse(
                                _controller.text.toString(),
                              )) return;
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Item Added to the cart.."),
                            ),
                          );
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addCartItem(
                            widget.product,
                            quantity: int.tryParse(
                              _controller.text.toString(),
                            ),
                          );
                        }
                      },
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(
                    child:
                        // Rendering shopping cart if in stock
                        widget.product.stockStatus == 'instock'
                            ? Text("Add to cart")
                            : Text("Out of stock"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  splashColor: Colors.teal,
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FixedBottomButtons extends StatelessWidget {
  const FixedBottomButtons({
    Key key,
    @required this.product,
  }) : super(key: key);

  final WooProduct product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Material(
            color: product.stockStatus != 'instock'
                ? Colors.grey.shade600
                : Colors.blueGrey.shade600,
            child: InkWell(
              splashColor: Colors.teal,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Rendering shopping cart if in stock
                    if (product.stockStatus == 'instock') ...[
                      Icon(
                        Icons.shopping_bag_rounded,
                      ),
                      Text("Add to cart"),
                    ],
                    // Rendering message if out of stock
                    if (product.stockStatus != 'instock') ...[
                      Text("Out of stock"),
                    ]
                  ],
                ),
              ),
              onTap: product.stockStatus != 'instock'
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Item Added to the cart.."),
                        ),
                      );
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addCartItem(product);
                    },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Material(
            color: Colors.red.shade400,
            child: InkWell(
              splashColor: Colors.red,
              child: SizedBox(
                height: 60,
                child: Icon(
                  Icons.favorite,
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Item Added to the favorites.."),
                  ),
                );
                Provider.of<FavoritesProvider>(context, listen: false)
                    .addToFavorites(product);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class NotifyMeWidget extends StatefulWidget {
  @override
  _NotifyMeWidgetState createState() => _NotifyMeWidgetState();
}

class _NotifyMeWidgetState extends State<NotifyMeWidget> {
  bool _agreeToContact;
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _agreeToContact = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade800,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Notify me when the item is back in stock.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v.isEmpty)
                    return 'Please provide an email';
                  else
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(v)
                        ? null
                        : 'Please provide a valid email address.';
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade700,
                  labelText: 'Email',
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _agreeToContact,
                  activeColor: Colors.blue,
                  onChanged: (v) {
                    setState(() {
                      _agreeToContact = !_agreeToContact;
                    });
                  },
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _agreeToContact = !_agreeToContact;
                        });
                      },
                      child: Text(
                        "I Agree to being contacted by the store owner.",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) ;
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Join mailling list"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

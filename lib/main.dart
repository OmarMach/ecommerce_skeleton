import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
          title: 'Ecommerce',
          theme: ThemeData(
            primarySwatch: Colors.green,
            brightness: Brightness.dark,
          ),
          routes: {
            ProductScreen.routeName: (context) => ProductScreen(),
          },
          home: Scaffold(
            appBar: AppBar(
              title: Text("Goods.tn"),
            ),
            body: SafeArea(
              child: Consumer<ProductProvider>(
                builder: (context, products, child) => GridView.builder(
                  itemCount: products.items.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      product: products.items[index],
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}

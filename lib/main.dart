import 'package:ecommerce_app/config.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
        ),
        routes: {ProductScreen.routeName: (context) => ProductScreen()},
        home: Scaffold(
          appBar: AppBar(
            title: Text("Goods.tn"),
          ),
          body: SafeArea(
            child: GridView.builder(
              itemCount: dummyList.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: dummyList[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            ),
          ),
        ));
  }
}

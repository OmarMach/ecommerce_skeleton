import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/test';
  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  bool isLoading = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              checkDatabaseConnection(context);
            },
            style: ElevatedButton.styleFrom(
              primary: error ? Colors.red : Colors.green,
            ),
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : Text("Test DB Connection"),
          ),
        ),
      ),
    );
  }

  Future<void> checkDatabaseConnection(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await CategoriesProvider().getAllCategories();
    } catch (e) {
      print("Error : " + e);
      setState(() {
        error = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

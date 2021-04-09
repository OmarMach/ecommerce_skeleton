import 'package:ecommerce_app/providers/categoriesProvider.dart';
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
    return Center(
      child: ElevatedButton(
        onPressed: checkDatabaseConnection,
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
    );
  }

  Future<void> checkDatabaseConnection() async {
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

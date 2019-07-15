import 'package:flutter/material.dart';
import 'package:flutter_app/strings.dart';

class ShoppingFlutter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ShoppingFlutterState();
  }
}

class ShoppingFlutterState extends State<ShoppingFlutter>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleShopping),
      ),
      body: Center(
        child: Text(
          Strings.bodyTextShopping,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }

}
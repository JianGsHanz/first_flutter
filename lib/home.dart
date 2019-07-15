import 'package:flutter/material.dart';
import 'strings.dart';

class HomeFlutter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeFlutterState();
  }
}

class HomeFlutterState extends State<HomeFlutter>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleHome),
      ),
      body: Center(
        child: Text(
          Strings.bodyTextHome,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }

}
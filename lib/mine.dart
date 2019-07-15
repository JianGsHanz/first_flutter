import 'package:flutter/material.dart';
import 'package:flutter_app/strings.dart';

class MineFlutter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MineFlutterState();
  }
}

class MineFlutterState extends State<MineFlutter>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleMine),
      ),
        body: Center(
          child: Text(
            Strings.bodyTextMine,
            style: TextStyle(fontSize: 25),
          ),
        )
    );
  }

}
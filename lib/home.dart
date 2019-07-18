import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFlutterState();
  }
}

class HomeFlutterState extends State<HomeFlutter> {
  @override
  Widget build(BuildContext context) {
    var wordPair = new WordPair.random();
    return Scaffold(
      body: Center(
        child: GestureDetector(
            //要监听Text事件必须把Text封装在GestureDetector里
            onTap: () =>
                Fluttertoast.showToast(msg: wordPair.asPascalCase), //Text点击时调用
            child: Text(
              wordPair.asPascalCase,
              style: TextStyle(fontSize: 25),
            )),
      ),
    );
  }
}

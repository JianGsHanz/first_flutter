import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'strings.dart';

class HomeFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFlutterState();
  }
}

class HomeFlutterState extends State<HomeFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector( //要监听Text事件必须把Text封装在GestureDetector里
            onTap: () => Fluttertoast.showToast(msg: Strings.bodyTextHome),//Text点击时调用
            child: Text(
              Strings.bodyTextHome,
              style: TextStyle(fontSize: 25),
            )),
      ),
    );
  }
}

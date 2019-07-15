import 'package:flutter/material.dart';
import 'package:flutter_app/shopping.dart';
import 'home.dart';
import 'mine.dart';

void main() => runApp(MyApp());

/*当一个控件状态是固定不可变的时候，就可以使用 StatelessWidget。
前面我们写的 Hello World 就是使用 StatelessWidget。*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: ZYHFlutter(),
    );
  }
}


/*当一个控件是可变的时候，就要使用 StatefulWidget 来构建。
 StatefulWidget 本身不可变，但它持有的状态 State 是可变的。*/

class ZYHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ZYHFlutterState();
  }
}

class ZYHFlutterState extends State<ZYHFlutter> {
  var _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView( //page页，根据controller控制显示哪个页面
        controller: _controller,
        children: <Widget>[HomeFlutter(), ShoppingFlutter(), MineFlutter()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap, //有tab被选中时调用
          currentIndex: _currentIndex, //当前被选中的tab
          items: [
            _createBottomNavigationBarItem(
                Icons.add_to_photos, Colors.grey, Colors.amber, 0, "首页"),
            _createBottomNavigationBarItem(
                Icons.add_shopping_cart, Colors.grey, Colors.amber, 1, "购物车"),
            _createBottomNavigationBarItem(
                Icons.account_circle, Colors.grey, Colors.amber, 2, "我的")
          ]),
    );
  }

  _createBottomNavigationBarItem(IconData icon, Color unSelectColor,
          Color selectColor, int index, String tabName) =>
      BottomNavigationBarItem(
          icon: Icon(
            icon,
            color: _currentIndex == index ? selectColor : unSelectColor,
          ),
          title: Text(
            tabName,
            style: TextStyle(
                color: _currentIndex == index ? selectColor : unSelectColor),
          ));

  void _onTap(int index) {
    setState(() {
      _controller.jumpToPage(index); //根据角标控制显示页面
      _currentIndex = index; //重新赋值选中的角标
    });
  }

}

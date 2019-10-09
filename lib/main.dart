import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/my_page_view.dart' as my;
import 'package:flutter_app/redux/app_state.dart';
import 'package:flutter_app/redux/theme_redux.dart';
import 'package:flutter_app/shopping.dart';
import 'package:flutter_app/strings.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'home.dart';
import 'mine.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

/*当一个控件状态是固定不可变的时候，就可以使用 StatelessWidget。
前面我们写的 Hello World 就是使用 StatelessWidget。*/
class MyApp extends StatelessWidget {
  final store = Store(
    appReducer,
    initialState: AppState(
      themeData: ThemeData(
        primaryColor: Colors.brown,
      )
    )
  );
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder: (context,state){
        return MaterialApp(
          theme: store.state.themeData,
          home: ZYHFlutter(store:state),
        );
      },),
    );
  }
}


/*当一个控件是可变的时候，就要使用 StatefulWidget 来构建。
 StatefulWidget 本身不可变，但它持有的状态 State 是可变的。*/

class ZYHFlutter extends StatefulWidget {
  Store store;
  ZYHFlutter({this.store});
  @override
  State<StatefulWidget> createState() {
    return new ZYHFlutterState(store:store);
  }
}

class ZYHFlutterState extends State<ZYHFlutter> {
  var _currentIndex = 0;
  var _themeIndex = 0; //默认颜色
  List<String> titles = [Strings.titleHome,Strings.titleShopping,Strings.titleMine];
  final PageController _controller = PageController();

  Store store;
  ZYHFlutterState({this.store});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
      ),
      drawer: buildDrawer(),
      body: my.PageView( //page页，根据controller控制显示哪个页面
        controller: _controller,//控制器
        onPageChanged: _onPageChange, //页面改变的同事更改角标
        children: <Widget>[HomeFlutter(), ShoppingFlutter(), MineFlutter()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap, //有tab被选中时调用
          currentIndex: _currentIndex, //当前被选中的tab
          items: [
            _createBottomNavigationBarItem(
                Icons.add_to_photos, Colors.grey, getThemeListColor()[_themeIndex], 0, "首页"),
            _createBottomNavigationBarItem(
                Icons.add_shopping_cart, Colors.grey, getThemeListColor()[_themeIndex], 1, "购物车"),
            _createBottomNavigationBarItem(
                Icons.account_circle, Colors.grey, getThemeListColor()[_themeIndex], 2, "我的")
          ]),
    );
  }
   //创建底部导航
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
  //底部导航点击回调
  void _onTap(int index) {
    setState(() { //调用setState() 会为State对象触发build()方法，从而导致对UI的更新
      _controller.jumpToPage(index); //根据角标控制显示页面
      _currentIndex = index; //重新赋值选中的角标
    });
  }
  //页面改变回调
  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('张*华'),
            accountEmail: Text('173****6464@163.com'),
            currentAccountPicture: CircleAvatar(
              child: Image.asset('images/test.jpg',width:100,height: 100,fit: BoxFit.cover,),
            ),
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('设置'),
          ),
          ListTile(
            leading: Icon(Icons.add_alarm),
            title: Text('提醒'),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('切换主题'),
            onTap: (){
              _showDialog();
            },
          )
        ],
      ),
    );
  }


  static List<Color> getThemeListColor() {
    return [
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  void _showDialog() {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return MediaQuery(
            ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child:  SafeArea(
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 300,
                      padding: new EdgeInsets.all(4.0),
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        //用一个BoxDecoration装饰器提供背景图片
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: ListView.builder(
                          itemCount: getThemeListColor().length,
                          itemBuilder: (context, index){
                            return RaisedButton(
                              color:getThemeListColor()[index],
                              onPressed: (){
                                _themeIndex = index;
                                store.dispatch(ThemeAction(themeData: ThemeData(primaryColor: getThemeListColor()[index])));
                                Navigator.of(context).pop(); //取消弹窗
                              },
                            );
                          }
                      ),
                    ),
                  )
              ));
        });
  }
}



import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ShoppingFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShoppingFlutterState();
  }
}

class ShoppingFlutterState extends State<ShoppingFlutter> {
  final _stateList = <WordPair>[]; //类型是WordPair的集合,List列表的内容
  final _saved = Set<WordPair>(); //用来储存用户 （收藏） 的单词Item,不允许重复

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildSuggestions());
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: EdgeInsets.all(16.0),
        /*对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        在偶数行，该函数会为单词对添加一个ListTile row.
        在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        注意，在小屏幕上，分割线看起来可能比较吃力。*/
        // ignore: missing_return
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _stateList.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _stateList.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_stateList[index], index); //如果为偶数就返回文字Item
        });
  }

  Widget _buildRow(WordPair pair, int index) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase, //随机生成的Text单词
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: StoreConnector<AppState,ThemeData>(
        converter: (store) => store.state.themeData,
        builder: (context,themeData){
          return new Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? themeData.primaryColor : null,
          );
        },
      ),
      selected: alreadySaved, //选中状态
      onTap: () {
        setState(() {
          //Item 为0 时--跳转路由
          if (index == 0) {
            _onRoutes();
          }
          //调用setState() 会为State对象触发build()方法，从而导致对UI的更新
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  _onRoutes() {
    Navigator.of(context).push(new MaterialPageRoute(
        // ignore: missing_return
        builder: (context) {
      //根据已收藏的集合转换为一个ListTile的集合
      final tiles = _saved.map(
        (pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: TextStyle(fontSize: 18.0),
            ),
          );
        },
      );
      //在Item直接添加分割线..
      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      //返回一个新的布局页面
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('one new page'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}

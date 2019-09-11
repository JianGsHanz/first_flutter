import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/**
 * 加载本地Json文件
 **/
class LoadingText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoadingText Title'),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/swordsmen.json'),
        // ignore: missing_return
        builder: (context, snapshot){
          if(!snapshot.hasData){ //snapshot快照里没数据 加载loading
            return Center(
              child: CircularProgressIndicator(), //圆形进度条
            );
          }else{
            List<dynamic> data = json.decode(snapshot.data.toString());
            print(data.toString());
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return SizedBox(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, top:10, right: 10,bottom: 10),
                            child: Text('''${data[index]['name']}
${data[index]['gongfu']}'''),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}



class RowStudy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row Title"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Text("TEXT 1",style: TextStyle(color: Colors.amber),),
            Text("TEXT 2",style: TextStyle(color: Colors.deepOrange),),
            Text("TEXT 3",style: TextStyle(color: Colors.blue),),
          ],
        ),
      ),
    );
  }
}






class ColumnStudy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column Title"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("TEXT 1",style: TextStyle(color: Colors.amber),),
            Text("TEXT 2",style: TextStyle(color: Colors.deepOrange),),
            Text("TEXT 3",style: TextStyle(color: Colors.blue),),
          ],
        ),
      ),
    );
  }
}





class WrapStudy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrap Title"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Wrap(
          direction: Axis.horizontal, //主轴方向
          spacing: 8.0, // 主轴方向的间距
          runSpacing: 8.0, // 交叉(纵)轴方向的间距
          children: <Widget>[
            Chip( //标签控件
              avatar: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text('1'),
              ),
              label: Text('TEXT 1'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text('2'),
              ),
              label: Text('TEXT 2'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text('3'),
              ),
              label: Text('TEXT 3333333333333333333333333'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text('4'),
              ),
              label: Text('TEXT 4'),
            ),
          ],
        ),
      ),
    );
  }
}


/**
 * 层式布局(相当于Android的FrameLayout)
 */
class StackStudy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack Title"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 20,
              top: 20,
              child: Image.asset("images/test.jpg",width: 300,height: 300,fit: BoxFit.cover),
            ),
            Positioned(
              left: 50,
              top: 150,
              child: Text('每天醒来第一句，先给自己打个气',style: TextStyle(color: Colors.amber,backgroundColor: Colors.black12),),
            ),
            Container(
              child: Image.asset("images/test.jpg",width: 50,height: 50,fit: BoxFit.cover,),
              alignment: Alignment.center,//没有用Positioned嵌套起来的子Widget,使用alignment属性来控制自身在父容器里的位置
            ),
          ],
        ),
      ),
    );
  }
}





/**
 * 弹性布局(相当于Android的FlexboxLayout)
 */
class FlexStudy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex Title"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Flex(
          direction: Axis.horizontal, //主轴的方向
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.yellow,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/bean/top_bean.dart';
import 'package:flutter_app/bean/video_bean.dart';

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




/**
 * Dio 网络请求
 */
class DioStudy extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DioStudyState();
  }
}
class DioStudyState extends State<DioStudy>{
  String _address = '';
  String topResult = ' ';
  var len = 0;
  List<Datum> data;
  List<Act> actS;
  var actLen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio Title"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
          ),
          child: _buildColumn(),
        ),
      )
    );
  }

  _buildColumn(){
    return Column(
      children: <Widget>[
        Text('请求结果为:'),
        Text(' $_address'),
        RaisedButton(
            splashColor: Colors.amber,
            textColor: Colors.amber,
            child: Text("请求网络(GET)"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              _getNetResult();
            }
        ),
        ///------------------------------------
        RaisedButton(
            splashColor: Colors.blue,
            textColor: Colors.blue,
            child: Text("请求网络(GET)展示到list"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              _getTopResult();
            }
        ),
        Container(
          height: 1200,
          child: ListView.separated(itemBuilder: (context,index){
            return ListTile(
              title: Text('${data[index].title}'),
            );
          },
            itemCount: len,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context,index){
              return Divider(
                height: 1,
                color: Colors.black,
              );
            },),
        ),
        ///------------------------------------
        RaisedButton(
            splashColor: Colors.redAccent,
            textColor: Colors.redAccent,
            child: Text("请求网络(POST)展示到list"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              _getVideoResult();
            }
        ),
        Container(
          height: 600,
          child: ListView.separated(itemBuilder: (context,index){
            return ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.network(
                    actS[index].image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,),
                  Text(actS[index].name),
                ],
              ),
            );
          },
            itemCount: actLen,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context,index){
              return Divider(
                height: 1,
                color: Colors.black,
              );
            },),
        ),
      ],
    );
  }

  _getVideoResult() async{
    var map = HashMap<String,dynamic>();
    map['q'] = '攀登者';
    map['key'] = '8aaa82f64c4f40936529aa6a251fdab4';
    var response = await Dio().post('http://op.juhe.cn/onebox/movie/video',queryParameters: map);
    if(response.statusCode == HttpStatus.ok){
      var bean = VideoBean.fromJson(jsonDecode(response.toString()));
      actS = bean.result.actS;
    }
    setState(() {
      actLen = actS.length;
    });
  }

  _getTopResult() async{
    var map = HashMap<String,dynamic>();
    map['type'] = 'top';
    map['key'] = '368dc8c1e591d5aa1258d6effb056f31';
    var response = await Dio().get('http://v.juhe.cn/toutiao/index',queryParameters: map);
    if(response.statusCode == HttpStatus.ok){
      Top top = Top.fromJson(jsonDecode(response.toString()));
      var result = top.result;
      data = result.data;
    }
    setState(() {
      len = data.length;
    });
  }
  _getNetResult() async{
    var result;
    try{
      var url = 'https://httpbin.org/ip';
      var response = await Dio().get(url);
      if(response.statusCode == HttpStatus.ok){
        var data = jsonDecode(response.toString());
        result = data['origin'];
      }
    }catch(e){
      result = e.toString();
    }
    setState(() {
      _address = result;
    });
  }
}
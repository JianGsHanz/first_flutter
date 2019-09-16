import 'package:flutter/material.dart';
import 'package:flutter_app/study/study_function.dart';

class HomeFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFlutterState();
  }
}

class HomeFlutterState extends State<HomeFlutter> {

  final List _list = getList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          padding: EdgeInsets.only(left:20.0,top:10.0,right:20.0,bottom:0.0),
          itemBuilder: (context, index){
            return ListTile(
              title: Text(_list[index]),
              onTap: (){
                onTap(index, context);
              },
            );
          },
          separatorBuilder: (context, index) { //ListView 分割线
            return Divider(
              height: 1,
              color: Colors.black,
            );
          },
          itemCount: _list.length
      )
    );
  }

  void onTap(int index, BuildContext context) {
    switch(index){
      case 0:
        Navigator.push(context,//新建路由
            MaterialPageRoute(builder: (context)=> LoadingText())
        );
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> RowStudy())
        );
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ColumnStudy())
        );
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> WrapStudy())
        );
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> StackStudy())
        );
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> FlexStudy())
        );
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> DioStudy())
        );
        break;
      case 7:
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> InteractionStudy())
        );
        break;
    }
  }
}

List getList() => List()
    ..add("加载本地json文本")
    ..add("水平线性布局(Row)")
    ..add("垂直线性布局(Column)")
    ..add("流式布局Widget(Wrap)")
    ..add("层式布局Widget(Stack)")
    ..add("弹性布局Widget(Flex)")
    ..add("Dio使用(网络请求)")
    ..add("android,flutter交互");

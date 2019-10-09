

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

///主题action
class ThemeAction{

  final ThemeData themeData;
  ThemeAction({this.themeData}); /// 1 step- dispatch

}

///通过 flutter_redux 的 combineReducers，实现 Reducer 方法
/// 这里combineReducers的作用是把action和函数绑定起来，
/// 免去了写例如if ( )之类的判断语句。
/// 对应的action执行对应的函数。
final ThemeDataReducer = combineReducers<ThemeData>([
  ///将 Action 、处理 Action 的方法、State 绑定   3 step- dispatch
  TypedReducer<ThemeData, ThemeAction>(_refresh),
]);

///定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, action) {
  themeData = action.themeData;   /// 4 step- dispatch
  return themeData;
}

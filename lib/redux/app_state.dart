import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/theme_redux.dart';

@immutable //只读，不可变
class AppState{
  ///主题数据
  ThemeData themeData;

  AppState({this.themeData});
}

///创建 Reducer
AppState appReducer(AppState state,action){
  return AppState(
      themeData: ThemeDataReducer(state.themeData,action) /// 2 step- dispatch
  );
}
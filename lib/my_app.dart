import 'package:flutter/material.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/pages/home.dart';
import 'package:notepad_demo/route/RouteSet.dart';
import 'package:notepad_demo/style/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppStateModel model;

  @override
  void initState() {
    super.initState();
    model = AppStateModel()..loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '在线商城',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: getRoute,
      debugShowCheckedModeBanner:false,
      theme: buildTheme(),
    );
  }
}

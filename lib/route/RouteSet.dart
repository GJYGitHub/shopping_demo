import 'package:flutter/material.dart';
import 'package:notepad_demo/pages/login.dart';

Route<dynamic> getRoute(RouteSettings settings) {

  switch (settings.name) {
    case '/login':
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('没有找到这个页面：${settings.name}')),
        ),
      );
  }
}

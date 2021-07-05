import 'package:flutter/material.dart';
import 'package:notepad_demo/model/app_state_model.dart';
import 'package:notepad_demo/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateModel>(
    create: (_) => AppStateModel(),
    child: MyApp(),
  ));
}

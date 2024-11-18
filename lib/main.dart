import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/superhero_viewmodel.dart';
import 'package:mvvm_flutter_app/task_ui.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(create:(context) => SuperheroViewModel(),
      child:  MyApp()),);
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuperheroView(),
    );
  }
}

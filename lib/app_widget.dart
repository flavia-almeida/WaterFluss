import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
 
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),),
        body: const Login(),
      ),

      /*      routes:{
        '/':(context) => const MyStatefulWidget(),
      }*/
    );
  }
}
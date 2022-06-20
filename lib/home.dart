import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'grafo_pizza.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _home();
}

class _home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: ElevatedButton(
                      child: const Text('Continuar sem login'),
                      onPressed: () {
                        print("aee");
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red)
                              )
                          )
                      )
                  )
              ),
            ],
          ),
      ),
    );
  }
}
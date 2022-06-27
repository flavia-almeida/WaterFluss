import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;
import 'package:flutter/material.dart';
import 'level_controller.dart';

class Carregando extends StatefulWidget {
  const Carregando({Key? key}) : super(key: key);

  @override
  _Carregando createState() => _Carregando();
}

class _Carregando extends State<Carregando> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Carregando',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(102, 102, 102, 1.0)),
                )),
          ],
        ));
  }
}

Future<bool> login(String user, String password, BuildContext context) async {
  var dio = Dio();
  var aux = {"email": user, "senha": password};
  log(aux.toString());
  var carrega = const Carregando();
  carrega;
  var response = await dio.post(
      'https://watterflussapiintegracao.azurewebsites.net/api/Usuario/Login',
      data: aux);
  if (response.statusCode == 201) {
    final body = (response.data.toString());
    globals.user = user;
    globals.isLoggedIn = true;

    globals.token = LoginResponse.fromJson(response.data).accessToken;
    log("logou, token: " + globals.token);
    Level_Check(context);
    return true;
  } else {
    log("não logou");
    CupertinoAlertDialog(
      title: const Text("Login não realizado"),
      actions: [
        CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
    return false;
  }
}

class LoginResponse {
  String accessToken = '';

  LoginResponse({required this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(accessToken: json['accessToken']);
}

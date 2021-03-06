import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'grafo_pizza.dart';
import 'controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _login();
}

class _login extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child:
                    new Image.asset('graphics/logo_waterfluss.png', width: 91)),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'WatterFluss',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(102, 102, 102, 1.0)),
                )),
            SizedBox(height: 30),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(102, 102, 102, 1.0)),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              width: 200,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(102, 102, 102, 1.0)),
                    hintText: "User",
                    fillColor: Colors.white70),
              ),
              //alignment: const Alignment(10.0, -1.0),
            ),
            SizedBox(height: 10),
            Container(
                width: 200,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: const Text(
                  'Senha',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(102, 102, 102, 1.0)),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              width: 200,
              child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(102, 102, 102, 1.0)),
                      hintText: "Password",
                      fillColor: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Esqueci minha senha',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: ElevatedButton(
                    child: const Text('Entrar'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                      login(nameController.text, passwordController.text,
                          context);
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.red)
                    ))))),
            SizedBox(height: 30),
          ],
        ));
  }
}

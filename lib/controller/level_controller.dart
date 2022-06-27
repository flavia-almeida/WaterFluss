import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;
import 'package:flutter/material.dart';
import '../caixadagua_globals.dart' as CaixaDagua;
import '../grafo_pizza.dart';

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

Future<bool> Abastecimento(BuildContext context) async {
  log("Level_check:");
  var dio = Dio();
  var carrega = const Carregando();
  carrega;
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer ${globals.token}";
  var response = await dio.get(
      'https://watterflussapiintegracao.azurewebsites.net/api/SensorVazao/VerificaAbastecimento');
  log("Abastecimento responde.data: "+response.data.toString());
  if (response.statusCode == 200) {
    CaixaDagua.Abastecimento = response.data;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Pizza()));
    return true;
  } else {
    CupertinoAlertDialog(
      title: const Text("Não foi possível obter os produtos!"),
      actions: [
        CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
    throw Exception('Não foi possível obter os produtos');
  }
}

class AbastecimentoResponse {
  final bool abastecimento;

  AbastecimentoResponse(
      {required this.abastecimento});

  factory AbastecimentoResponse.fromJson(Map<String, dynamic> json) => AbastecimentoResponse(
      abastecimento: json['idReservatorio']);
}

Future<bool> Level_Check(BuildContext context) async {
  log("Level_check:");
  var dio = Dio();
  var carrega = const Carregando();
  carrega;
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer ${globals.token}";
  var response = await dio.get(
      'https://watterflussapiintegracao.azurewebsites.net/api/SensorNivel/BuscarMedicao');

  if (response.statusCode == 200) {
    log("PEGOU");
    CaixaDagua.alturaReservatorio =
        CaixaResponse.fromJson(response.data).alturaReservatorio;
    CaixaDagua.idReservatorio =
        CaixaResponse.fromJson(response.data).idReservatorio;
    CaixaDagua.dataHora = CaixaResponse.fromJson(response.data).dataHora;
    CaixaDagua.sensorNivel = CaixaResponse.fromJson(response.data).sensorNivel;

    Abastecimento(context);
    return true;
  } else {
    CupertinoAlertDialog(
      title: const Text("Não foi possível obter os produtos!"),
      actions: [
        CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
    throw Exception('Não foi possível obter os produtos');
  }
}

class CaixaResponse {
  final int idReservatorio;
  final String dataHora;
  final double sensorNivel;
  final double alturaReservatorio;

  CaixaResponse(
      {required this.idReservatorio,
      required this.dataHora,
      required this.sensorNivel,
      required this.alturaReservatorio});

  factory CaixaResponse.fromJson(Map<String, dynamic> json) => CaixaResponse(
      idReservatorio: json['idReservatorio'],
      dataHora: json['dataHora'],
      sensorNivel: json['sensorNivel'],
      alturaReservatorio: json['alturaReservatorio']);
}

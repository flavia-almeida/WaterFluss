import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pizza extends StatefulWidget {
  Pizza({Key? key}) : super(key: key);
  @override
  State<Pizza> createState() => _PizzaState();
}

class Data {
  final String nome;
  final double porcent;
  final Color color;
  Data({required this.nome, required this.porcent, required this.color});
}

class _PizzaState extends State<Pizza> {
  double valor = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Grafico(),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 15, 30, 10),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 15, 30, 10),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(122, 97, 186, 1.0)),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 15, 30, 10),
                      child: const Text(
                        'Água disponível',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(102, 102, 102, 1.0)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Data> data = [
    Data(
        nome: 'contem',
        porcent: 15000,
        color: Color.fromRGBO(122, 97, 186, 1.0)),
    Data(
        nome: 'vazio',
        porcent: 5000,
        color: Color.fromRGBO(255, 255, 255, 1.0)),
  ];

  List<PieChartSectionData> getSections() => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: data.color,
          value: data.porcent,
          //title: '${data.porcent.toStringAsFixed(0)} L',
          title: '',
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        );
        return MapEntry(index, value);
      })
      .values
      .toList();

  Grafico() {
    if ((valor <= 0)) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.topLeft,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 50,
                  sections: getSections(),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

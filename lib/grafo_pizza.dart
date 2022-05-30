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
          children: <Widget>[Grafico()],
        ),
      ),
    );
  }

  set_dados() {
    return List.generate(1, (index) {
      final fontSize = 14.0;
      final Radius = 0.0;
      final color = Color.fromARGB(255, 56, 72, 214);

      return PieChartSectionData(
          color: Color.fromARGB(255, 56, 72, 214),
          value: valor * 100,
          title: '${valor.toStringAsFixed(0)}%',
          radius: 110.0);
    });
  }

  List<Data> data = [
    Data(
        nome: 'contem',
        porcent: 15000,
        color: Color.fromRGBO(102, 102, 102, 1.0)),
    Data(
        nome: 'vazio',
        porcent: 5000,
        color: Color.fromRGBO(255, 255, 255, 1.0)),
  ];

  List<PieChartSectionData> getSections() => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
            color: data.color, value: data.porcent, title: '${data.porcent}%');
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
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 5,
                centerSpaceRadius: 0,
                sections: getSections(),
              ),
            ),
          ),
        ],
      );
    }
  }
}

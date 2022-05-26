import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pizza extends StatefulWidget {
  Pizza({Key? key}) : super(key: key);

  @override
  State<Pizza> createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  double valor = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top:50),
          
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Grafico()],
        ),
      ),
    );
  }

  set_dados(){
    return List.generate(1, (index) {
      final fontSize = 14.0;
      final Radius = 0.0;
      final color = Color.fromARGB(255, 56, 72, 214);

      return PieChartSectionData(
                color: Color.fromARGB(255, 56, 72, 214),
                value: valor * 100,
                title: '${valor.toStringAsFixed(0)}%',
                radius: 110.0
              );
    });
  }

  Grafico(){
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
              centerSpaceRadius: 50,
              sections: set_dados(),
            ),
          ),
        ),
      ],
    );
    }
  }
}




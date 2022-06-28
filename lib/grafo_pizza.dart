import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../caixadagua_globals.dart' as CaixaDagua;
import 'controller/level_controller.dart';

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

class NivelMessageWidget extends StatelessWidget {
  final double? altura;
  final double? total;

  // ignore: use_key_in_widget_constructors
  const NivelMessageWidget({@required this.altura, @required this.total});

  @override
  Widget build(BuildContext context) {
    return Text('Água Disponível: ${altura.toString()} de ${total.toString()}');
  }
}

class AbastecimentoMessageWidget extends StatelessWidget {
  final String? texto;

  // ignore: use_key_in_widget_constructors
  const AbastecimentoMessageWidget({@required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text('$texto');
  }
}

class _PizzaState extends State<Pizza> {
  double valor = -1;
  double percent_tot = -1;
  String texto = "";

  List<Data> data = [
    Data(
        nome: 'contem',
        porcent: CaixaDagua.sensorNivel,
        color: Color.fromRGBO(122, 97, 186, 1.0)),
    Data(
        nome: 'vazio',
        porcent: CaixaDagua.alturaReservatorio - CaixaDagua.sensorNivel,
        color: Color.fromRGBO(255, 255, 255, 1.0)),
  ];

  @override
  Future reload() async {
    await BuscaLevel();
    await BuscaAbastecimento();

    final List<Data> data = [
      Data(
          nome: 'contem',
          porcent: CaixaDagua.sensorNivel,
          color: Color.fromRGBO(122, 97, 186, 1.0)),
      Data(
          nome: 'vazio',
          porcent: CaixaDagua.alturaReservatorio - CaixaDagua.sensorNivel,
          color: Color.fromRGBO(255, 255, 255, 1.0)),
    ];
    final percent_tot = CaixaDagua.alturaReservatorio - CaixaDagua.sensorNivel;
    final valor = CaixaDagua.sensorNivel;
    if (CaixaDagua.Abastecimento == true) {
      final texto = "Atualmente há abastecimento!";
    } else {
      final texto = "Atualmente não há abastecimento!";
    }

    setState(() => this.data = data);
    setState(() => this.percent_tot = percent_tot);
    setState(() => this.valor = valor);
    setState(() => this.texto = texto);
    Grafico();
  }

  Widget build(BuildContext context) {
    valor = CaixaDagua.sensorNivel;
    percent_tot = CaixaDagua.alturaReservatorio - CaixaDagua.sensorNivel;
    if (CaixaDagua.Abastecimento == true) {
      texto = "Atualmente há abastecimento!";
    } else {
      texto = "Atualmente não há abastecimento!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitoramento"),
      ),
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
                    child: Row(
                      children: [
                        NivelMessageWidget(
                            altura: CaixaDagua.sensorNivel,
                            total: CaixaDagua.alturaReservatorio),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(10, 15, 30, 10),
              child: Row(
                children: [
                  AbastecimentoMessageWidget(texto: texto),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reload,
        tooltip: 'Increment',
        child: const Icon(Icons.update),
      ),
    );
  }

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
      reload();
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

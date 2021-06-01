import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/evolution.dart';
import 'package:siteica_user/services/evolution_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class EvolutionPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EvolutionPage(),
      );

  @override
  _EvolutionPageState createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  final _evolutionService = Injector.appInstance.get<EvolutionService>();
  List<charts.Series<LinearEvolution, DateTime>> _chartData = [];

  _getEvolutionData() async {
    List<Evolution> _evolution = await _evolutionService.getEvolution();

    List<LinearEvolution> _linearEvolution = [];

    _evolution.forEach((element) {
      var date = new DateTime.fromMicrosecondsSinceEpoch(element.date * 1000);
      _linearEvolution.add(LinearEvolution(date, element.totalCases));
    });

    _chartData = [
      new charts.Series<LinearEvolution, DateTime>(
        id: 'Casos diarios',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearEvolution evolution, _) => evolution.date,
        measureFn: (LinearEvolution evolution, _) => evolution.total,
        data: _linearEvolution,
      )
    ];

    setState(() {});
  }

  @override
  void initState() {
    _getEvolutionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Evolution test"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: charts.TimeSeriesChart(
            _chartData,
            animate: true,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
          ),
        ),
      ),
    );
  }
}

class LinearEvolution {
  final DateTime date;
  final int total;

  LinearEvolution(this.date, this.total);
}

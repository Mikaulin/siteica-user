import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/evolution.dart';
import 'package:siteica_user/models/evolution_province_total.dart';
import 'package:siteica_user/services/evolution_province_service.dart';
import 'package:siteica_user/services/evolution_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'common/title.dart';

class EvolutionPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EvolutionPage(),
      );

  @override
  _EvolutionPageState createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  final _evolutionService = Injector.appInstance.get<EvolutionService>();
  final _evolutionProvinceService =
      Injector.appInstance.get<EvolutionProvinceService>();
  List<charts.Series<LinearEvolution, DateTime>> _chartData = [];
  List<Widget> _dataByProvince = [];

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

  _getDataByProvince() async {
    List<EvolutionProvinceTotal> _totalByProvince =
        await _evolutionProvinceService.getEvolutionProvinceTotals();

    _totalByProvince.forEach((element) {
      _dataByProvince.add(
        Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                element.provinceName,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                element.total.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      );
    });
    setState(() {});
  }

  @override
  void initState() {
    _getEvolutionData();
    _getDataByProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Evolution test"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: Column(
              children: [
                CommonTitle(title: "Casos diarios"),
                Container(
                  height: 300,
                  child: charts.TimeSeriesChart(
                    _chartData,
                    animate: true,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                  ),
                ),
                CommonTitle(title: "Provincia"),
                Column(
                  children: _dataByProvince,
                )
              ],
            )),
      ),
    );
  }
}

class LinearEvolution {
  final DateTime date;
  final int total;

  LinearEvolution(this.date, this.total);
}

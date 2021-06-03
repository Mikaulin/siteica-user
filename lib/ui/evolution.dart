import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/evolution.dart';
import 'package:siteica_user/models/evolution_province_total.dart';
import 'package:siteica_user/services/evolution_province_service.dart';
import 'package:siteica_user/services/evolution_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:siteica_user/ui/common/linear_evolution.dart';

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
  int _total = 0;
  int _lastMonthTotal = 0;
  int _lastWeekTotal = 0;

  _getTotals() async {
    _total = await _evolutionService.getTotal();
    _getLastMonthTotal();
    _getLastWeekTotal();
  }

  _getLastMonthTotal() async {
    var now = new DateTime.now();
    var lastDayPrevMonth = new DateTime(now.year, now.month, 0);
    var firstDayPrevMonth = new DateTime(now.year, now.month - 1, 1);

    _lastMonthTotal = await _evolutionService.getTotalBetweenDates(
      firstDayPrevMonth.millisecondsSinceEpoch,
      lastDayPrevMonth.millisecondsSinceEpoch,
    );
  }

  _getLastWeekTotal() async {
    var now = new DateTime.now();
    var firstDayPrevWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));

    _lastWeekTotal = await _evolutionService.getTotalBetweenDates(
      firstDayPrevWeek.millisecondsSinceEpoch,
      now.millisecondsSinceEpoch,
    );
  }

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
  }

  @override
  void initState() {
    _getEvolutionData();
    _getDataByProvince();
    _getTotals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos de evolución"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: Column(
              children: [
                CommonTitle(title: "Resumen"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              "Esta semana",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Text(
                            _lastWeekTotal == null
                                ? "-"
                                : _lastWeekTotal.toString(),
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              "Mes anterior",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Text(
                            _lastMonthTotal == null
                                ? "-"
                                : _lastMonthTotal.toString(),
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              "Total",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Text(
                            _total == null ? "-" : _total.toString(),
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CommonTitle(title: "Casos diarios"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                    ),
                    height: 300,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: charts.TimeSeriesChart(
                      _chartData,
                      animate: true,
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                    ),
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

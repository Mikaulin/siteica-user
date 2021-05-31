import 'dart:async';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/risk_encounter.dart';
import 'package:siteica_user/models/risk_encounter_analysis.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/ble_service.dart';
import 'package:siteica_user/services/encounter_seed_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/services/risk_encounter_analysis_service.dart';
import 'package:siteica_user/services/risk_encounter_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/common/info_title.dart';
import 'package:siteica_user/ui/common/themes.dart';
import 'package:siteica_user/ui/common/title.dart';
import 'package:siteica_user/ui/notification.dart';
import 'package:siteica_user/utils/constants.dart';
import 'dart:io' show Platform;

import 'package:siteica_user/utils/time_util.dart';

class HomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userService = Injector.appInstance.get<UserService>();
  final _encounterService = Injector.appInstance.get<EncounterService>();
  final _encounterSeedService =
      Injector.appInstance.get<EncounterSeedService>();
  final _riskEncounterService =
      Injector.appInstance.get<RiskEncounterService>();
  final _riskEncounterAnalysisService =
      Injector.appInstance.get<RiskEncounterAnalysisService>();

  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  bool _bluetoothEnabled = false;
  bool _riskFound = false;

  _configureDeviceForBle() async {
    User _user = await _userService.getUser();
    startBroadcast(_user);
    startObserver(
      _user,
      beaconEventsController,
      _encounterService,
      _encounterSeedService,
    );
    await _checkSelfRisk(_user);
  }

  _checkBluetoothAndEnable() async {
     BluetoothEnable.enableBluetooth.then((value) {
      if (value == "true") {
        setState(() {
          _bluetoothEnabled = true;
        });
      }
    });
  }

  _checkSelfRisk(User _user) async {
    RiskEncounterAnalysis _analysis =
        await _riskEncounterAnalysisService.getLastRiskEncounterAnalysis();

    if (_analysis == null ||
        timeExceeded(_analysis.date, RISK_ANALYSIS_TIME_PERIOD)) {

      List<EncounterSeed> _encounterSeeds =
          await _encounterSeedService.getEncounterSeeds(_user);
      List<RiskEncounter> _myRiskEncounters = await _riskEncounterService
          .getSelfEncounterRisk(_user, _encounterSeeds);
      _riskFound = _myRiskEncounters
          .any((element) => element.duration >= RISK_DURATION_INTERVAL);
      _riskEncounterAnalysisService.addRiskEncounterAnalysis(_riskFound);

    } else {
      _riskFound = _analysis.riskFound == 1;
    }

    setState(() {});
  }

  @override
  void initState() {
    _checkBluetoothAndEnable();
    super.initState();
    _configureDeviceForBle();
  }

  @override
  void dispose() {
    beaconEventsController.close();
    super.dispose();
  }

  List<Widget> _riskEncounterData() {
    return [
      CommonTitle(title: "Contactos de riesgo"),
      InformationTitle(
        title: _riskFound
            ? "Se ha detectado contacto de riesgo."
            : "No se han detectado contactos de riesgo.",
        warning: _riskFound,
      ),
      Text(
        _riskFound
            ? "Te recomendamos que contactes con tu centro de salud y sigas "
                "las recomendaciones que te ofrezcan."
            : "Serás informado en caso de que se registre un posible contacto "
                "de riesgo tras el análisis automatizado.",
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 21.0),
      )
    ];
  }

  List<Widget> _systemStatus() {
    List<Widget> _widgetList = <Widget>[
      CommonTitle(title: "Estado del sistema"),
      InformationTitle(
        title: _bluetoothEnabled
            ? "El sistema está actualmente activo"
            : "El sistema no está activo.",
        warning: !_bluetoothEnabled,
      ),
      Text(
        "Siteica hace uso del Bluetooth para comunicarse con dispositivos "
        "cercanos y mantenerte protegido.",
      )
    ];

    if (!_bluetoothEnabled) {
      _widgetList.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: raisedButtonStyle,
            onPressed: _checkBluetoothAndEnable,
            child: Text('Habilitar Bluetooth'),
          ),
        ),
      );
    }

    _widgetList.add(Padding(
      padding: const EdgeInsets.only(bottom: 21.0),
    ));

    return _widgetList;
  }

  List<Widget> _positiveNotification() {
    return [
      CommonTitle(title: "Notificar positivo"),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          "Notifica tu positivo con tu clave temporal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationPage()),
          );
        },
        child: Text('Notificar'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _content = <Widget>[];
    _content.addAll(_riskEncounterData());
    _content.addAll(_systemStatus());
    _content.addAll(_positiveNotification());

    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _content,
          ),
        ),
      ),
    );
  }
}

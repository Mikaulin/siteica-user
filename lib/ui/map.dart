import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:latlong/latlong.dart';
import 'package:siteica_user/models/risk_encounter.dart';
import 'package:siteica_user/services/risk_encounter_service.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';
import 'package:siteica_user/utils/geolocator_util.dart';

class MapPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => MapPage(),
      );

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _riskEncounterService =
      Injector.appInstance.get<RiskEncounterService>();
  List<Marker> _riskMarkers = <Marker>[];
  Position _position;
  bool _isLoading = true;

  _getRiskEncounters() async {
    List<RiskEncounter> _riskEncounters =
        await _riskEncounterService.getAllRiskEncounters();
    _riskEncounters.forEach((element) {
      _riskMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(element.latitude, element.longitude),
          builder: (ctx) => Container(
            child: Icon(
              Icons.warning_amber_outlined,
              color: Colors.red,
              size: 24.0,
              semanticLabel: 'Contacto de riesgo',
            ),
          ),
        ),
      );
    });

    _position = await determinePosition();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getRiskEncounters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de infección"),
      ),
      body: _isLoading
          ? CommonProgressIndicator()
          : Center(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(_position.latitude, _position.longitude),
                  zoom: 16.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(
                    markers: _riskMarkers,
                  ),
                ],
              ),
            ),
    );
  }
}

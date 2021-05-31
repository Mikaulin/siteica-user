import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/api_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/services/private_notification_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/start.dart';

import 'common/themes.dart';
import 'common/title.dart';

class NotifyConfirmationPage extends StatefulWidget {
  final DateTime selectedDate;
  final String diagnosticCode;

  const NotifyConfirmationPage({
    Key key,
    this.selectedDate,
    this.diagnosticCode,
  }) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotifyConfirmationPage(),
      );

  @override
  _NotifyConfirmationPageState createState() => _NotifyConfirmationPageState();
}

class _NotifyConfirmationPageState extends State<NotifyConfirmationPage> {
  final _privateNotificationService =
      Injector.appInstance.get<PrivateNotificationService>();
  final _userService = Injector.appInstance.get<UserService>();
  final _apiService = Injector.appInstance.get<ApiService>();
  final _encounterService = Injector.appInstance.get<EncounterService>();

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Positivo notificado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Gracias por notificar tu caso.'),
                Text(
                    'Los datos anónimos de tus encuentros se han almacenado en la nube.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  _continue(String otpValue, int diagnosticDate) async {
    User _user = await _userService.getUser();
    await _privateNotificationService.addPrivateNotification(
        _user, otpValue, diagnosticDate);
    _notifyToServer(otpValue, diagnosticDate);
    _showDialog();
  }

  _notifyToServer(String otpValue, int diagnosticDate) async {
    await _apiService.createNotification(otpValue, diagnosticDate);
    List<Encounter> _encounters = await _encounterService.getEncounters();
    await _apiService.uploadEncounters(_encounters);
  }

  @override
  Widget build(BuildContext context) {
    String _dateFormattedValue =
        widget.selectedDate.toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("Notificar positivo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTitle(title: "Datos de diagnóstico"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tu código es: ${widget.diagnosticCode}",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tu fecha del diagnóstico es:  $_dateFormattedValue",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              CommonTitle(title: "Información adicional"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "SITEICA no recopila información personal de ningún tipo. Si pulsar en el botón Notificar, se compartirán los datos anónimos sobre tus encuentros para notificar a otros usuarios sobre el posible riesgo. En caso de no estar de acuerdo, pulsa en el botón Cancelar.",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        _continue(
                          widget.diagnosticCode,
                          widget.selectedDate.millisecondsSinceEpoch,
                        );
                      },
                      child: Text('Continuar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

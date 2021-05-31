import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/private_notification.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/private_notification_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/utils/format_util.dart';

import 'common/themes.dart';
import 'common/title.dart';
import 'notify_confirmation.dart';

class NotificationPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotificationPage(),
      );

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final inputController = TextEditingController();
  final _privateNotificationService =
      Injector.appInstance.get<PrivateNotificationService>();
  final _userService = Injector.appInstance.get<UserService>();
  bool _otpCorrect = false;

  _continue(DateTime _selectedDate, String _otp) async {
    User _user = await _userService.getUser();
    PrivateNotification _notification = await _privateNotificationService
        .searchPrivateNotificationByOtpValue(_user, _otp);

    if (_notification == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotifyConfirmationPage(
            selectedDate: _selectedDate,
            diagnosticCode: _otp,
          ),
        ),
      );
    } else {
      _showOtpUsedDialog();
    }
  }

  _showOtpUsedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Código ya usado"),
        content: Text(
            "El código de diagnóstico que has introducido ya ha sido utilizado."),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = DateTime.now();

    _selectDate() async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != _selectedDate)
        setState(() {
          _selectedDate = picked;
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notificar positivo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CommonTitle(title: "Código de diagnóstico"),
              TextField(
                controller: inputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Introduce tu código de diagnóstico',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  NotificationNumberFormatter(),
                ],
                onChanged: (text) {
                  setState(() {
                    _otpCorrect = inputController.text.length >= 12;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ejemplo: 012-3456-789",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              CommonTitle(title: "Fecha del diagnóstico"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Si recuerdas el día en el que comenzaron los síntomas, introdúcelo a continuación. En caso contrario, introduce la fecha de diagnóstico.",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 21.0),
                  ),
                ),
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: !_otpCorrect
                    ? null
                    : () {
                        _continue(_selectedDate, inputController.text);
                      },
                child: Text('Notificar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

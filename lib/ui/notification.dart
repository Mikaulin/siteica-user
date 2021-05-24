import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siteica_user/utils/format_util.dart';

import 'common/themes.dart';
import 'common/title.dart';

class NotificationPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotificationPage(),
      );

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Introduce tu código de diagnóstico',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  NotificationNumberFormatter(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ejemplo: 012-3456-789",
                  style: TextStyle(fontSize: 14.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

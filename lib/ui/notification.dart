import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siteica_user/utils/format_util.dart';

import 'common/themes.dart';
import 'common/title.dart';

class NotificationPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotificationPage(),
      );

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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

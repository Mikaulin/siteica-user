import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/province.dart';
import 'package:siteica_user/services/province_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';
import 'package:siteica_user/ui/common/themes.dart';
import 'package:siteica_user/ui/common/title.dart';
import 'package:siteica_user/ui/start.dart';
import 'package:bluetooth_enable/bluetooth_enable.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _provinceService = Injector.appInstance.get<ProvinceService>();
  final _userService = Injector.appInstance.get<UserService>();
  List<Province> _provinces;
  Province _selectedProvince;
  bool _continue = false;

  getProvinces() async {
    _provinces = await _provinceService.getProvinces();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProvinces();
  }

  _addUser() async {
    await _userService.addUser(provinceId: _selectedProvince.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartPage()),
    );
  }

  Future<void> _enableBluetooth() async {
    BluetoothEnable.enableBluetooth.then((value) {
      if (value == "true") {
        setState(() {
          _continue = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_provinces == null) {
      return CommonProgressIndicator();
    }

    _selectedProvince ??= _provinces.first;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comenzar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CommonTitle(title: "Activa el Bluetooth"),
              Text(
                "SITEICA hace uso del Bluetooth de baja energía para comunicarse"
                " con otras aplicaciones cercanas. Habilita el Bluetooth para"
                " comenzar a usar la aplicación.",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: _enableBluetooth,
                  child: Text('Habilitar Bluetooth'),
                ),
              ),
              CommonTitle(title: "Selecciona tu provincia"),
              Text(
                "Conocer tu provincia nos ayuda a realizar análisis estadísticos sobre la enfermedad."
                "Para mantener el anonimato, ¡no te preguntaremos nada más!",
              ),
              DropdownButton<Province>(
                isExpanded: true,
                value: _selectedProvince,
                onChanged: (Province newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                  });
                },
                items: _provinces
                    .map<DropdownMenuItem<Province>>((Province value) {
                  return DropdownMenuItem<Province>(
                    value: value,
                    child: Text(value.provinceName),
                  );
                }).toList(),
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
                      onPressed: _continue ? _addUser : null,
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

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/province.dart';
import 'package:siteica_user/services/province_service.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';
import 'package:siteica_user/ui/common/title.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _provinceService = Injector.appInstance.get<ProvinceService>();
  List<Province> _provinces;
  Province _selectedProvince;

  getProvinces() async {
    _provinces = await _provinceService.getProvinces();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    if (_provinces == null) {
      return CommonProgressIndicator();
    }

    _selectedProvince ??= _provinces.first;

    return Scaffold(
      appBar: AppBar(
        title: Text("*Register test"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTitle(title: "Registro"),
            DropdownButton<Province>(
              value: _selectedProvince,
              onChanged: (Province newValue) {
                setState(() {
                  _selectedProvince = newValue;
                });
              },
              items:
                  _provinces.map<DropdownMenuItem<Province>>((Province value) {
                return DropdownMenuItem<Province>(
                  value: value,
                  child: Text(value.provinceName),
                );
              }).toList(),
            )
          ],
        ),
      ),
      // Center(
      //   child: Text("Hello, Register!"),
      // ),
    );
  }
}

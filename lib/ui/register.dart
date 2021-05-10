import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/province.dart';
import 'package:siteica_user/services/province_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';
import 'package:siteica_user/ui/common/themes.dart';
import 'package:siteica_user/ui/common/title.dart';
import 'package:siteica_user/ui/start.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _provinceService = Injector.appInstance.get<ProvinceService>();
  final _userService = Injector.appInstance.get<UserService>();
  List<Province> _provinces;
  Province _selectedProvince;

  getProvinces() async {
    _provinces = await _provinceService.getProvinces();
    setState(() {});
  }

  _addUser() async {
    await _userService.addUser(provinceId: _selectedProvince.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartPage()),
    );
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
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: _addUser,
              child: Text('Looks like a RaisedButton'),
            ),
          ],
        ),
      ),
      // Center(
      //   child: Text("Hello, Register!"),
      // ),
    );
  }
}

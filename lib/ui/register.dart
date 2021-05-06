import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Register test"),
      ),
      body: Center(
        child: Text("Hello, Register!"),
      ),
    );
  }


// await _userService.addUser(
//   uuid: Uuid.randomUuid().toString(),
//   date: DateTime.now().millisecondsSinceEpoch,
//   provinceId: 1,
// );
}
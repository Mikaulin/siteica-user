import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Home test"),
      ),
      body: Center(
        child: Text("Hello, Home!"),
      ),
    );
  }
}
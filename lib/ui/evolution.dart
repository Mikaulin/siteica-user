import 'package:flutter/material.dart';

class EvolutionPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => EvolutionPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Evolution test"),
      ),
      body: Center(
        child: Text("Hello, Evolution!"),
      ),
    );
  }
}
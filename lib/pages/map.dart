import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => MapPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Map test"),
      ),
      body: Center(
        child: Text("Hello, Map!"),
      ),
    );
  }
}
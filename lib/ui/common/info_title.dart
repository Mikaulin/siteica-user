import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationTitle extends StatelessWidget {
  final String title;
  final bool warning;

  InformationTitle({@required this.title, this.warning = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        this.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: this.warning ? Colors.deepOrange : Colors.black,
        ),
      ),
    );
  }
}

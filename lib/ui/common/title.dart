import 'package:flutter/material.dart';

class CommonTitle extends StatelessWidget {
  final String title;

  CommonTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.black)
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTitle extends StatelessWidget {
  final String title;

  CommonTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),
            textAlign: TextAlign.right,
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

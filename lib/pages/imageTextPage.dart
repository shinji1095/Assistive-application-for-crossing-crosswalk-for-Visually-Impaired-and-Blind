import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class imageTextPage extends StatelessWidget{
  Widget imageBox;
  Widget textBox;

  imageTextPage(this.imageBox, this.textBox);


  @override
  Widget build(BuildContext context) =>
    SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: imageBox,//
          ),
          Flexible(
            flex: 1,
            child: textBox)
        ],
      ),
    );
}
import 'package:flutter/material.dart';

class BoxButtonPage extends StatelessWidget{
  Widget BoxWidget;
  Widget ButtonWidget;

  BoxButtonPage(this.BoxWidget, this.ButtonWidget);

  Widget build(BuildContext context)
  => SizedBox(
    width: double.infinity,
    child: Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: BoxWidget,
        ),
        Flexible(
          flex: 1,
          child: ButtonWidget,
        )
      ],
    ),
  );

}
import 'package:flutter/material.dart';
import 'package:app_a/pages/boxButtonPage.dart' as page;
import 'package:app_a/parts/homeBoxWidget.dart' as parts;
import 'package:app_a/parts/homeButtonWidget.dart' as parts;


class HomeView extends StatelessWidget{
  const HomeView({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context)
    => Scaffold(
      appBar: AppBar(title: const Text('Assistive App for VIB')),
      body:page.BoxButtonPage(
        parts.HomeBoxWidget(),
        parts.HomeButtonWidget()
      )
    );
}
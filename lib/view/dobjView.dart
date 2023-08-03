import 'package:flutter/material.dart';
import 'package:app_a/pages/imageTextPage.dart' as page;
import 'package:app_a/parts/dobjImageWidget.dart' as parts;
import 'package:app_a/parts/dobjTextWidget.dart' as parts;

class DObjView  extends StatelessWidget{
  const DObjView({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context)
  => Scaffold(
    appBar: AppBar(title: const Text('Assistive App for VIB'),),
    body: page.imageTextPage(
        parts.DObjImageWidget(),
        const parts.DObjTextWidget()
    ),
  );
}
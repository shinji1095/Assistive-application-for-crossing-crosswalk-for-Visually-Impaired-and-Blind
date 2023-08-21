import 'package:flutter/material.dart';
import 'package:app_a/pages/imageTextPage.dart' as page;
import 'package:app_a/parts/captionImageWidget.dart' as parts;
import 'package:app_a/parts/captionTextWidget.dart' as parts;

class CaptionView  extends StatelessWidget{
  const CaptionView({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context)
  => Scaffold(
    appBar: AppBar(title: const Text('Assistive App for VIB'),),
    body: page.imageTextPage(
        const parts.CaptionImageWidget(),
        const parts.CaptionTextWidget()
    ),
  );
}
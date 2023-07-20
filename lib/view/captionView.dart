import 'package:flutter/material.dart';
import 'package:app_a/pages/imageTextPage.dart' as page;
import 'package:app_a/parts/captionImageWidget.dart' as parts;
import 'package:app_a/parts/captionTextWidget.dart' as parts;

class CaptionView  extends StatelessWidget{
  CaptionView({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context)
  => page.imageTextPage(
      parts.CaptionImageWidget(),
      parts.CaptionTextWidget()
  );
}
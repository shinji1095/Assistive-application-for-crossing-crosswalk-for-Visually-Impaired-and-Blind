import 'package:flutter/material.dart';
import 'package:app_a/pages/boxButtonPage.dart' as page;
import 'package:app_a/parts/settingButtonWidget.dart' as parts;
import 'package:app_a/parts/settingBoxWidget.dart' as parts;

class DObjView  extends StatelessWidget{
  DObjView({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context)
  => page.BoxButtonPage(
      parts.SettingBoxWidget(),
      parts.SettingButtonWidget()
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_a/view/dobjView.dart' as dobjView;
import 'package:app_a/view/captionView.dart' as captionView;
import 'package:app_a/view/settingView.dart' as settingView;
import 'pages/boxButtonPage.dart' as boxButtonPage;

void main() => runApp(const ProviderScope(child: MyApp()));

class _Home extends StatelessWidget{
  const _Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
   => Scaffold(
     appBar: AppBar(title: const Text('Assistive app for Visually Impaired on the crosswalk'),),
     body: boxButtonPage.BoxButtonPage(
       Text('tt'),
       Text('dd')
     )
     );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
    => MaterialApp(
      title: 'Assistive app for Visually Impaired on the crosswalk',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const _Home(),
      routes: <String, WidgetBuilder> {
        '/caption': (context) => captionView.CaptionView(),
        '/dobj   ': (context) => dobjView.DObjView(),
        '/setting' : (context) => settingView.SettingView()
      },
    );
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

import 'package:app_a/view/homeView.dart'    as homeView;
import 'package:app_a/view/dobjView.dart'    as dobjView;
import 'package:app_a/view/captionView.dart' as captionView;
import 'package:app_a/view/settingView.dart' as settingView;
import 'pages/boxButtonPage.dart' as boxButtonPage;

late List<CameraDescription> cameras;
StateProvider<CameraDescription?> cameraProvider = StateProvider((ref) => null);

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras =await availableCameras();
  runApp(const ProviderScope(child: MyApp()) );
}

class _Home extends StatelessWidget{
  const _Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
   => const homeView.HomeView();
}

class MyApp extends StatelessWidget{
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context)
    => MaterialApp(
      title: 'Assistive app for Visually Impaired on the crosswalk',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const _Home(),
      routes: <String, WidgetBuilder> {
        '/caption':  (context) => captionView.CaptionView(),
        '/dobj':     (context) => const dobjView.DObjView(),
        '/setting' : (context) => settingView.SettingView()
      },
    );
}

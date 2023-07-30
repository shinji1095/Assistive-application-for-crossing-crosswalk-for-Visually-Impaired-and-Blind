import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:app_a/main.dart' as main;

final _cameras = main.cameras;

class DObjImageWidget extends StatefulWidget{
  const DObjImageWidget({Key? key}) : super(key: key);

  @override
  State<DObjImageWidget> createState() => _DObjImageWidget();
}

class _DObjImageWidget extends State<DObjImageWidget>{
  late CameraController controller;

  @override
  void initState(){
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_){
      if (!mounted){
        return;
      }
      setState(() {});
    }).catchError((Object e){
      if (e is CameraException){
        switch (e.code){
          case 'CameraAccessDenied':
            print('User denied camera access');
            break;
          default:
            print('Handle  other  error');
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!controller.value.isInitialized){
      return Container();
    }
    return CameraPreview(controller);
  }
}
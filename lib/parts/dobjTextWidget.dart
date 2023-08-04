import 'package:flutter/material.dart';
import 'package:app_a/data/entity/recognition.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_a/data/model/ml_camera.dart';


class DObjTextWidget extends HookWidget {
  const DObjTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recognitions = useProvider(recognitionsProvider);
    final size = MediaQuery.of(context).size;
    final mlCamera = useProvider(mlCameraProvider(size));

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: mlCamera.when(
        data:(mlCamera)=> textField(
            recognitions.state,
            mlCamera.actualPreviewSize,
            mlCamera.ratio
          ),
        loading: ()
          => const Center(child: CircularProgressIndicator(),),
        error: (Object err, StackTrace? stackTrace)
          => Center(child: Text(err.toString()),)
      )
    );
  }

  Widget textField(
      List<Recognition> recognitions,
      Size? actualPreviewSize,
      double? ratio,
  ){
    if  (recognitions.isEmpty){
      return const SizedBox();
    }return SizedBox(
      child: Column(
        children: recognitions.map((result){
        return Row(
          children: <Widget>[
              Text(result.label),
              Text(' ${result.score.toStringAsFixed(2)}')
            ],
          );
        }
      ).toList()
    ));
  }
}

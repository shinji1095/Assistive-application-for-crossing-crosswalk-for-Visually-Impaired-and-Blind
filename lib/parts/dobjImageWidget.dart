import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_a/data/entity/recognition.dart';
import 'package:app_a/data/model/ml_camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DObjImageWidget extends HookWidget{
  const DObjImageWidget({super.key});

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final mlCamera = useProvider(mlCameraProvider(size));
    final recognitions = useProvider(recognitionsProvider);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: mlCamera.when(
          data: (mlCamera)=>Stack(
            children: [
              CameraPreview(mlCamera.cameraController),
              buildBoxes(
                recognitions.state,
                mlCamera.actualPreviewSize,
                mlCamera.ratio,
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Center(
            child: Text(err.toString()),
          )
      ),
    );
  }

  /// バウンディングボックスを構築
  Widget buildBoxes(
      List<Recognition> recognitions,
      Size? actualPreviewSize,
      double? ratio,
      ) {
    if (recognitions.isEmpty) {
      return const SizedBox();
    }return Stack(
      children: recognitions.map((result) {
        return BoundingBox(
          result,
          actualPreviewSize,
          ratio,
        );
      }).toList(),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView(
      this.cameraController, {super.key}
      );
  final CameraController cameraController;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }
}

class BoundingBox extends HookWidget {
  const BoundingBox(
      this.result,
      this.actualPreviewSize,
      this.ratio,
      );
  final Recognition result;
  final Size? actualPreviewSize;
  final double? ratio;
  @override
  Widget build(BuildContext context) {
    final renderLocation = result.getRenderLocation(
      actualPreviewSize!,
      ratio!,
    );
    return Positioned(
      left: renderLocation.left,
      top: renderLocation.top,
      width: renderLocation.width,
      height: renderLocation.height,
      child: Container(
        width: renderLocation.width,
        height: renderLocation.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        child: buildBoxLabel(result, context),
      ),
    );
  }

  /// 認識結果のラベルを表示
  Align buildBoxLabel(Recognition result, BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FittedBox(
        child: ColoredBox(
          color: Theme.of(context).highlightColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result.label,
              ),
              Text(
                ' ${result.score.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// final _cameras = main.cameras;

// class _DObjImageWidget extends State<DObjImageWidget> {
//   late CameraController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(_cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             print('User denied camera access');
//             break;
//           default:
//             print('Handle  other  error');
//             break;
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return CameraPreview(controller);
//   }
//
//   void _start() {
//     controller?.startImageStream(_processImage);
//   }
//
//   void _processImage(CameraImage cameraImage){
//
//   }
// }
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_a/data/entity/recognition.dart';
import 'package:app_a/data/model/classifier.dart';
import 'package:app_a/utils/image_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

final recognitionsProvider = StateProvider<List<Recognition>>((ref) => []);

final mlCameraProvider =
FutureProvider.autoDispose.family<MLCamera, Size>((ref, size) async {
  final cameras = await availableCameras();
  final cameraController = CameraController(
    cameras[0],
    ResolutionPreset.low,
    enableAudio: false,
  );
  await cameraController.initialize();
  final mlCamera = MLCamera(
    ref.read,
    cameraController,
    size,
  );
  return mlCamera;
});

class MLCamera {
  MLCamera(
      this._read,
      this.cameraController,
      this.cameraViewSize,
      ) {
    Future(() async {
      classifier = Classifier();
      ratio = Platform.isAndroid
          ? cameraViewSize.width / cameraController.value.previewSize!.height
          : cameraViewSize.width / cameraController.value.previewSize!.width;
      actualPreviewSize = Size(
        cameraViewSize.width,
        cameraViewSize.width * ratio!,
      );
      // 画像ストリーミングを開始
      await cameraController.startImageStream(onLatestImageAvailable);
    });
  }
  final Reader _read;
  final CameraController cameraController;

  /// スクリーンのサイズ
  Size cameraViewSize;

  /// アスペクト比
  double? ratio;

  /// 識別器
  Classifier? classifier;

  /// 現在推論中か否か
  bool isPredicting = false;

  /// カメラプレビューの表示サイズ
  Size? actualPreviewSize;

  /// 画像ストリーミングに対する処理
  Future<void> onLatestImageAvailable(CameraImage cameraImage) async {
    if (isPredicting) {
      return;
    }
    isPredicting = true;
    final isolateCamImgData = IsolateData(
      cameraImage: cameraImage,
      interpreterAddress: classifier!.interpreter!.address,
      labels: classifier!.labels,
    );

    // 推論処理は重く、Isolateを使わないと画面が固まる
    _read(recognitionsProvider).state =
    await compute(inference, isolateCamImgData);
    isPredicting = false;
  }

  /// Isolateへ渡す推論関数
  /// Isolateには、static関数か、クラスに属さないトップレベル関数しか渡せないため、staticに
  static Future<List<Recognition>> inference(
      IsolateData isolateCamImgData) async {
    var image = ImageUtils.convertYUV420ToImage(
      isolateCamImgData.cameraImage!,
    );
    if (Platform.isAndroid) {
      image = image_lib.copyRotate(image, 90);
    }

    final classifier = Classifier(
      interpreter: Interpreter.fromAddress(
        isolateCamImgData.interpreterAddress!,
      ),
      labels: isolateCamImgData.labels!,
    );

    return Future<List<Recognition>>.value(classifier.predict(image));
  }
}

class IsolateData {
  IsolateData({
     this.cameraImage,
     this.interpreterAddress,
     this.labels,
  });
  CameraImage? cameraImage;
  int? interpreterAddress;
  List<String>? labels;
}
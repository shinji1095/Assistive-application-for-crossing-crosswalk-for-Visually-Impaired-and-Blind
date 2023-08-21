import 'dart:convert';
import 'package:app_a/utils/image_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';


const String serverURL = 'https://ad09-150-69-237-49.ngrok-free.app/caption';
final isRequestingProvider = StateProvider((ref) => false);
final captionProvider = StateProvider((ref) => []);

// final cameraProvider =
// FutureProvider.autoDispose.family<HttpCamera, Size>((ref, size) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final cameraController = CameraController(
//     cameras[0],
//     ResolutionPreset.low,
//     // enableAudio: false,
//   );
//   await cameraController.initialize();
//   final httpCamera = HttpCamera(
//     ref.read,
//     cameraController,
//     size,
//   );
//   return httpCamera;
// });
//
// class HttpCamera {
//   final Reader _read;
//   final CameraController cameraController;
//
//   /// スクリーンのサイズ
//   Size cameraViewSize;
//
//   /// アスペクト比
//   double? ratio;
//
//   /// カメラプレビューの表示サイズ
//   Size? actualPreviewSize;
//
//   HttpCamera(
//       this._read,
//       this.cameraController,
//       this.cameraViewSize,
//       ){
//     Future(() async {
//       ratio = io.Platform.isAndroid
//           ? cameraViewSize.width / cameraController.value.previewSize!.height
//           : cameraViewSize.width / cameraController.value.previewSize!.width;
//       actualPreviewSize = Size(
//         cameraViewSize.width,
//         cameraViewSize.width * ratio!,
//       );
//       // 画像ストリーミングを開始
//       await cameraController.startImageStream(onLatestImageAvailable);
//     });
//   }
//   /// 画像ストリーミングに対する処理
//   Future<void> onLatestImageAvailable(CameraImage cameraImage) async {
//     if (!_read(isRequestingProvider).state) {
//       return;
//     }
//     // final image = await cameraController.takePicture();
//     final image = ImageUtils.convertYUV420ToImage(cameraImage);
//     // String imageByte = cameraImage.toString();
//     Uri url = Uri.parse(serverURL);
//     Map<String, String> headers = {'content-type': 'application/json'};
//     String body = json.encode({
//       'status':'OK',
//       'img':image.data
//     });
//     http.Response resp = await http.post(
//       url,
//       headers: headers,
//       body: body
//     );
//     _read(captionProvider).state = resp.statusCode != 200 ? ['something wrong...'] : [resp.body];
//     _read(isRequestingProvider).state = false;
//     return;
//   }
// }
//
// class CaptionImageWidget extends HookWidget {
//   const CaptionImageWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final controller = useProvider(cameraProvider(size));
//     return SizedBox(
//       child: controller.when(
//           data: (controller)=>SizedBox(child: CameraPreview(controller.cameraController),),
//           loading: ()=>const Center(child: CircularProgressIndicator()),
//           error: (err, stack) => Center(child: Text(err.toString()),)
//       ),
//     );
//   }
// }

final cameraProvider = FutureProvider.autoDispose<CameraDescription>((ref) async {
  final cameras = await availableCameras();
  return cameras.first;
});

class CaptionImageWidget extends ConsumerWidget {
  const CaptionImageWidget({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final camera = watch(cameraProvider);
    return SizedBox(
        child: camera.when(
        data: (camera)=>TakePictureScreen(camera: camera),
        loading:() => Center(child: CircularProgressIndicator(),),
        error: (err, stack)=>Text(err.toString()))
    );
  }
}

/// 写真撮影画面
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      // カメラを指定
      widget.camera,
      // 解像度を定義
      ResolutionPreset.medium,
    );

    // コントローラーを初期化
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    _controller.dispose();
    super.dispose();
  }

  Future<http.Response> multipart({
    required String method,
    required Uri url,
    required List<http.MultipartFile> files,
  }) async {
    final request = http.MultipartRequest(method, url);

    request.files.addAll(files); // 送信するファイルのバイナリデータを追加

    final stream = await request.send();

    return http.Response.fromStream(stream).then((response) {
      if (response.statusCode == 200) {
        return response;
      }

      return Future.error(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 写真を撮る
          final image = await _controller.takePicture();
          // String imageByte = cameraImage.toString();
          Uri url = Uri.parse(serverURL);

          final response = await multipart(
              method: 'POST',
              url: url,
              files:[
                http.MultipartFile.fromBytes('media', io.File(image.path).readAsBytesSync())
              ]
          );
          // Map<String, String> headers = {"Content-type": "multipart/form-data"};
          final request = http.MultipartRequest('POST', url);
          final file = io.File(image.path);
          request.files.add(
            http.MultipartFile(
              'file',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: image.name,
              contentType: MediaType.parse('image/jpeg'),
            ),
          );
          // request.headers.addAll(headers);

          http.StreamedResponse resp = await request.send();
          http.Response.fromStream(resp).then((res) async {
            if(res.statusCode == 200){
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      DisplayPictureScreen(
                          imgPath: image.path,
                          caption: resp.statusCode != 200 ? " " : resp.toString()
                      ),
                    fullscreenDialog: true,
                  )
              );
            }else{
              print(res.body);
            }
          });
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// 撮影した写真を表示する画面
class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.caption, required this.imgPath})
      : super(key: key);

  final String caption;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(caption)),
      body: Center(child: Image.file(io.File(imgPath))),
    );
  }
}
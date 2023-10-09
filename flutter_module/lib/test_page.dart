import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ImageProvider _imageProvider = const NetworkImage("http://temp.im/123x456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Page')),
      body: Center(
        // child: Image.asset('assets/images/warning.png'),
        child: Image(image: _imageProvider),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateImage,
        tooltip: 'Generate',
        child: const Icon(Icons.add),
      ),
    );
  }

  _generateImage() {
    // GenImage.generateImage().then((generatedImage) async {
    _getImageFromCanvas().then((generatedImage) async {
      ByteData? image =
          await generatedImage.toByteData(format: ui.ImageByteFormat.png);

      if (image == null) {
        return;
      }

      // String base64 = base64Encode(image.buffer.asInt64List());
      // print(base64);
      // Uint8List bytes = base64Decode(base64);
      // _imageProvider = MemoryImage(bytes);

      _imageProvider = MemoryImage(image.buffer.asUint8List());

      setState(() {});
    });
  }

  Future<ui.Image> _getImageFromCanvas() async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    ui.Image image = await _getImageFromPath('assets/images/warning.png');
    paintImage(
      canvas: canvas,
      image: image,
      rect: const Rect.fromLTRB(0, 0, 30, 30),
      fit: BoxFit.fill,
    );
    var locationSize = 60 * 2;
    final img = await pictureRecorder
        .endRecording()
        .toImage(30.toInt(), 30.toInt() + locationSize.toInt());
    return img;
  }

  Future<ui.Image> _getImageFromPath(String asset, {width, height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}

class GenImage {
  static Future<ui.Image> generateImage() async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas c = Canvas(recorder);
    var rect = const Rect.fromLTWH(0.0, 0.0, 200.0, 200.0);
    c.clipRect(rect);

    final paint = Paint();
    paint.strokeWidth = 1;
    paint.color = const Color(0xFF0000FF);
    paint.style = PaintingStyle.stroke;

    const offset = Offset(100.0, 100.0);
    c.drawCircle(offset, 50.0, paint);
    var picture = recorder.endRecording();
    final image = await picture.toImage(500, 500);
    return image;
  }
}

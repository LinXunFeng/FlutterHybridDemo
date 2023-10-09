import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double lat = 25.067207;

  double lng = 121.5266216;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    // addMarker();

    // controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    // controller.loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Center(
        // child: FlutterLogo(),
        child: _buildMap(),
        // child: _buildWebView(),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      width: 200,
      height: 300,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(lat, lng)),
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  // Widget _buildWebView() {
  //   return WebViewWidget(controller: controller);
  // }

  Future<ui.Image> getImageFromPath(String asset, {width, height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<void> addMarker() async {
    MarkerId markerId = const MarkerId("marker-location");
    try {
      final icon = await createBitmapImageFromBytes(
        'assets/images/warning.png',
        const Size(64, 64),
      );

      var marker = Marker(
        markerId: markerId,
        position: LatLng(lat, lng),
        icon: icon,
      );

      setState(() {
        markers[markerId] = marker;
      });
    } catch (e) {
      debugPrint('e - $e');
    }
  }

  /// create from byte
  Future<BitmapDescriptor> createBitmapImageFromBytes(
    String imageName,
    Size size,
  ) async {
    debugPrint('imageName -- $imageName');
    try {
      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      ui.Image locationImage = await getImageFromPath(imageName);
      paintImage(
        canvas: canvas,
        image: locationImage,
        rect: Rect.fromLTRB(
          0,
          0,
          size.width,
          size.height,
        ),
        fit: BoxFit.fill,
      );

      final img = await pictureRecorder.endRecording().toImage(
            size.width.toInt(),
            size.height.toInt(),
          );
      final data = await img.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List uint8List = data!.buffer.asUint8List();
      return BitmapDescriptor.fromBytes(uint8List);
    } catch (e) {
      debugPrint('e - $e');
      rethrow;
    }
  }
}

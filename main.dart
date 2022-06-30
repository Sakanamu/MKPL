import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => TP_09();
}

class TP_09 extends State<Camera> {
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  int selectedCamera = 0;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    cameras = [];
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      // cameraController =
      //     CameraController(cameras[selectedCamera], ResolutionPreset.medium);
      // await cameraController!.initialize();
    } on CameraException catch (_) {
      debugPrint("Some error occured");
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isReady = true;
    });
  }

  @override
  void dispose() {
    // cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: FutureBuilder(
    //     future: initializeCamera(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return CameraPreview(cameraController!);
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: cameras.length,
          itemBuilder: (context, index) {
            final listCamera = cameras[index];
            return ListTile(
              title: Text("Camera name: " + listCamera.name),
              subtitle: Text("Sensor Orientation: " +
                  listCamera.sensorOrientation.toString()),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
class CameraOpen extends StatefulWidget {
  const CameraOpen({super.key});

  @override
  State<CameraOpen> createState() => _CameraOpenState();
}

class _CameraOpenState extends State<CameraOpen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              openCamera();
            },
            child: const Text('Open Camera'),
        ),
      ),
      ]
    );
  }
}

Future<void> openCamera() async {
  CameraController? cameraController;
  
  final List<CameraDescription> cameras = await availableCameras();
  if (cameras.isNotEmpty) {
    cameraController = CameraController(
        cameras[0], ResolutionPreset.low);
    await cameraController.initialize();
    // You can now use the cameraController to display the camera preview or capture images.
  } else {
    print('No cameras available.');
  }
}
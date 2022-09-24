import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CameraScreen extends StatefulWidget {
  late List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> cameraValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraValue = controller.initialize();
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.aspectRatio,
                    child: CameraPreview(controller));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // return new AspectRatio(
              //   aspectRatio: MediaQuery.of(context).size.aspectRatio,
              //   child: new CameraPreview(controller),
              // );
            }),
        Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.flash_off,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.panorama_fish_eye,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Hold for video, tap for photo",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:slhack/future/object3d.dart';
// import 'package:camera/camera.dart';

class FutureUiMobile extends StatefulWidget {
  FutureUiMobile({Key key}) : super(key: key);

  @override
  _FutureUiMobileState createState() => _FutureUiMobileState();
}

class Message {
  Message({this.title, this.content});
  final String title;
  final String content;
}

class _FutureUiMobileState extends State<FutureUiMobile>
    with SingleTickerProviderStateMixin {
  Message message;
  double _end = 0;

  @override
  void initState() {
    super.initState();
    _initMessages();
  }

  void _initMessages() async {
    await Future.delayed(Duration(seconds: 2));
    await _showMessage(Message(title: 'FlutterHack', content: 'hello world'));
    await Future.delayed(Duration(seconds: 1));
    await _showMessage(Message(title: 'FlutterHack', content: 'hello world2'));
  }

  Future<void> _showMessage(Message msg) async {
    setState(() {
      message = msg;
    });
    await Future.wait([
      playLocalAsset(),
      Future.delayed(Duration(seconds: 3)),
    ]);

    setState(() {
      message = null;
    });
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    return await cache.play("sound/ios_ding.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            message != null
                ? TweenAnimationBuilder(
                    tween: Tween<double>(begin: -500, end: _end),
                    duration: Duration(seconds: 2),
                    builder: (context, margin, child) {
                      return Positioned(
                        right: margin,
                        child: SafeArea(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            constraints: BoxConstraints(maxWidth: 320),
                            // TODO: show message with animation sliding from right to left
                            // and dismiss message with sliding from left to right
                            child: MacAlertMessage(
                              title: message.title,
                              message: message.content,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Object3D(
                    size: Size(MediaQuery.of(context).size.width, 280.0),
                    zoom: 35.0,
                    path: "assets/bird.obj",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MacAlertMessage extends StatelessWidget {
  const MacAlertMessage({
    Key key,
    @required this.title,
    @required this.message,
  })  : assert(
          title != null,
          message != null,
        ),
        super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(60, 60, 60, 0),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromRGBO(80, 80, 80, 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // direction: Axis.horizontal,
          children: [
            CircleAvatar(
              radius: 18,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(105, 105, 105, 1),
                        Color.fromRGBO(50, 50, 50, 1),
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class FutureUiMobile extends StatefulWidget {
//   const FutureUiMobile({Key key}) : super(key: key);

//   @override
//   _FutureUiMobileState createState() => _FutureUiMobileState();
// }

// class _FutureUiMobileState extends State<FutureUiMobile> {
//   CameraController controller;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     print('😨');
//     print(cameras);
//     controller = CameraController(cameras[0], ResolutionPreset.medium);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller.value.isInitialized) {
//       return Container();
//     }
//     return AspectRatio(
//         aspectRatio: controller.value.aspectRatio,
//         child: CameraPreview(controller));
//   }
// }

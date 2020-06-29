// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

// import 'package:flutter/material.dart';

// import 'ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;

// class FutureUiWeb extends StatelessWidget {
//   const FutureUiWeb({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency,
//       child: WebcamPage(),
//     );
//   }
// }

// class WebcamPage extends StatefulWidget {
//   @override
//   _WebcamPageState createState() => _WebcamPageState();
// }

// class _WebcamPageState extends State<WebcamPage> {
//   Widget _webcamWidget;
//   VideoElement _webcamVideoElement;
//   bool _isRegistered = false;
//   @override
//   void initState() {
//     super.initState();
//     if (!_isRegistered) {
//       _register();
//     }
//     _webcamVideoElement.play();
//   }

//   void _register() {
//     // Create a video element which will be provided with stream source
//     _webcamVideoElement = VideoElement();
//     // Register an webcam
//     ui.platformViewRegistry.registerViewFactory(
//         'webcamVideoElement', (int viewId) => _webcamVideoElement);
//     // Create video widget
//     _webcamWidget =
//         HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');
//     // Access the webcam stream
//     window.navigator.getUserMedia(video: true).then((MediaStream stream) {
//       _webcamVideoElement.srcObject = stream;
//     });
//     setState(() => _isRegistered = true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: _webcamWidget,
//         ),
//         Positioned.fill(
//           child: Container(
//             decoration: BoxDecoration(
//                 gradient: RadialGradient(
//               radius: 0.8,
//               colors: [
//                 Colors.greenAccent.withOpacity(0.1),
//                 Colors.black.withOpacity(1),
//               ],
//             )),
//           ),
//         ),
//         Positioned(left: 40, top: 40, child: _buildOverlays()),
//         Positioned(right: 40, top: 40, child: _buildOverlays()),
//         RaisedButton(
//           child: Text('show me'),
//           onPressed: () {
//             _webcamVideoElement.play();
//           },
//         )
//       ],
//     );
//   }

//   Widget _buildOverlays() {
//     return Wrap(
//       direction: Axis.vertical,
//       spacing: 16,
//       children: [
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//         OverlayUI(
//           child: Text('hello world'),
//         ),
//       ],
//     );
//   }
// }

// class OverlayUI extends StatelessWidget {
//   const OverlayUI({Key key, this.child}) : super(key: key);

//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       color: Colors.white10,
//       width: 300,
//       height: 120,
//       child: DefaultTextStyle(
//         style: TextStyle(color: Colors.white70),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             child,
//           ],
//         ),
//       ),
//     );
//   }
// }
